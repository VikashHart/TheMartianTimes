import UIKit

protocol ArticleVCViewModeling {
    var article: FormattedArticle { get }
}

class ArticleVCViewModel: ArticleVCViewModeling {
    let article: FormattedArticle

    init(article: FormattedArticle) {
        self.article = article
    }
}
