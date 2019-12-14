import UIKit

protocol ListVCViewModeling {
    var cellSpacing: CGFloat { get }
    var numberOfCells: CGFloat { get }
    var numberOfSpaces: CGFloat { get }
    var selectedSegment: Int { get }
    var currentLanguage: LanguageType { get set }
    var articles: [FormattedArticle] { get }
    var onDataRecieved: (() -> Void)? { get set }
    var onErrorRecieved: (() -> Void)? { get set }

    func loadInitialData()
}

class ListVCViewModel: ListVCViewModeling {

    let cellSpacing: CGFloat
    let numberOfCells: CGFloat
    let numberOfSpaces: CGFloat
    var selectedSegment: Int
    var currentLanguage: LanguageType {
        didSet {
            switch self.currentLanguage {
            case .english:
                switchToEnglish()
            case .martian:
                switchToMartian()
            }
        }
    }
    private(set) var articles: [FormattedArticle] = [] {
        didSet {
            DispatchQueue.main.async {
                self.onDataRecieved?()
            }
        }
    }

    private var originalArticles: [FormattedArticle] = []
    private var translatedArticles: [FormattedArticle] = []

    private let translator: Translatable
    private let userDefaults = Defaults()

    var onDataRecieved: (() -> Void)?
    var onErrorRecieved: (() -> Void)?

    private let apiClient: ArticleRetrievable

    init(cellSpacing: CGFloat = 10,
         numberOfCells: CGFloat = 1,
         selectedSegment: Int = 0,
         apiClient: ArticleRetrievable = NewsAPIClient(),
         translator: Translatable = Translator(),
         currentLanguage: LanguageType = LanguageType.english) {
        self.cellSpacing = cellSpacing
        self.numberOfCells = numberOfCells
        self.numberOfSpaces = numberOfCells + 1
        self.apiClient = apiClient
        self.translator = translator
        switch userDefaults.retrieveActiveLanguage() {
        case 0:
            self.currentLanguage = .english
            self.selectedSegment = 0
        case 1:
            self.currentLanguage = .martian
            self.selectedSegment = 1
        default:
            self.currentLanguage = currentLanguage
            self.selectedSegment = selectedSegment
        }
    }

    func loadInitialData() {
            switch self.currentLanguage {
            case .english:
                getData(completion: { (articles) in
                        self.articles = articles
                })
            case .martian:
                self.switchToMartian()
            }
    }

    private func getData(completion: @escaping ([FormattedArticle]) -> Void) {
        if originalArticles.isEmpty == true {
            apiClient.getArticles(completion: { [weak self] (result) in
                switch result {
                case .success(let data):
                    for article in data {
                        self?.originalArticles.append(article)
                    }
                    completion(data)
                case .failure( _):
                    self?.onErrorRecieved?()
                }
            })
        } else {
            completion(originalArticles)
        }
    }

    private func switchToEnglish() {
        if originalArticles.isEmpty == true {
            loadInitialData()
        } else {
            articles = originalArticles
        }
        userDefaults.saveActiveLanguage(setting: setLanguage())
    }

    private func switchToMartian() {
        if translatedArticles.isEmpty == true {
            getData { (articles) in
                for article in articles {
                    let article = self.translator.translateArticle(article: article)
                    self.translatedArticles.append(article)
                }
                self.articles = self.translatedArticles
            }
        } else {
            self.articles = translatedArticles
        }
        userDefaults.saveActiveLanguage(setting: setLanguage())
    }

    private func setLanguage() -> Int {
        switch currentLanguage {
        case .english:
            return 0
        case .martian:
            return 1
        }
    }
}
