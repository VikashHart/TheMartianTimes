import Foundation

protocol ArticleCachable {
    var isEmpty: Bool { get }
    func cacheArticle(with url: URL, for article: FormattedArticle)
    func getArticles() -> [FormattedArticle]
}
