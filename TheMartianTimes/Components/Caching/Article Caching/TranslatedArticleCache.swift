import Foundation

class TranslatedArticlesCache: ArticleCachable {
    static let shared = TranslatedArticlesCache()
    private var articleCache: [URL: FormattedArticle] = [:]

    var isEmpty: Bool = true

    func cacheArticle(with url: URL, for article: FormattedArticle) {
        if articleCache[url] != nil {
            // article already exists
            isEmpty = false
        } else {
            articleCache[url] = article
        }
    }

    func getArticles() -> [FormattedArticle] {
        var articles: [FormattedArticle] = []

        for article in articleCache {
            articles.append(article.value)
        }
        return articles
    }
}
