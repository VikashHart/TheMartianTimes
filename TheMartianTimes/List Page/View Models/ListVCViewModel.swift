import UIKit

protocol ListVCViewModeling {
    var cellSpacing: CGFloat { get }
    var numberOfCells: CGFloat { get }
    var numberOfSpaces: CGFloat { get }
    var articles: [Article] { get }
    var onDataRecieved: (() -> Void)? { get set }
    var onErrorRecieved: (() -> Void)? { get set }

    func loadInitialData()
}

class ListVCViewModel: ListVCViewModeling {

    let cellSpacing: CGFloat
    let numberOfCells: CGFloat
    let numberOfSpaces: CGFloat
    private (set) var articles: [Article] = [] {
        didSet {
            DispatchQueue.main.async {
                self.onDataRecieved?()
            }
        }
    }

    var onDataRecieved: (() -> Void)?
    var onErrorRecieved: (() -> Void)?

    private let apiClient: ArticleRetrievable

    init(cellSpacing: CGFloat = 10, numberOfCells: CGFloat = 1, apiClient: ArticleRetrievable = NewsAPIClient()) {
        self.cellSpacing = cellSpacing
        self.numberOfCells = numberOfCells
        self.numberOfSpaces = numberOfCells + 1
        self.apiClient = apiClient
    }

    func loadInitialData() {
        apiClient.getArticles(completion: { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.articles = data
                print(data)
            case .failure(let error):
                print(error)
                self?.onErrorRecieved?()
            }
        })
    }
}
