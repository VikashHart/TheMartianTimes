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

    private let translator: Translator
    private let userDefaults = Defaults()

    var onDataRecieved: (() -> Void)?
    var onErrorRecieved: (() -> Void)?

    private let apiClient: ArticleRetrievable

    init(cellSpacing: CGFloat = 10,
         numberOfCells: CGFloat = 1,
         selectedSegment: Int = 0,
         apiClient: ArticleRetrievable = NewsAPIClient(),
         translator: Translator = Translator(),
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
        if OriginalArticlesCache.shared.isEmpty == true {
            apiClient.getArticles(completion: { [weak self] (result) in
                switch result {
                case .success(let data):
                    for article in data {
                        if let url = article.imageURL {
                        OriginalArticlesCache.shared.cacheArticle(with: url, for: article)
                        }
                    }
                    completion(data)
                case .failure( _):
                    self?.onErrorRecieved?()
                }
            })
        } else {
            completion(OriginalArticlesCache.shared.getArticles())
        }
    }

    private func switchToEnglish() {
        if OriginalArticlesCache.shared.isEmpty == true {
            loadInitialData()
        } else {
            articles = OriginalArticlesCache.shared.getArticles()
        }
        userDefaults.saveActiveLanguage(setting: setLanguage())
    }

    private func switchToMartian() {
        if TranslatedArticlesCache.shared.isEmpty == true {
            getData { (articles) in
                var dataSource: [FormattedArticle] = []
                for article in articles {
                    let article = self.translator.translateArticle(article: article)
                    dataSource.append(article)
                    guard let url = article.imageURL else { return }
                    TranslatedArticlesCache.shared.cacheArticle(with: url, for: article)
                }
                self.articles = dataSource
            }
        } else {
            self.articles = TranslatedArticlesCache.shared.getArticles()
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
