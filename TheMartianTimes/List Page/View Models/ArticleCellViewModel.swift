import UIKit

protocol ArticleCellViewModeling {
    var formattedArticle: FormattedArticle { get }
}

class ArticleCellViewModel: ArticleCellViewModeling {
    var formattedArticle: FormattedArticle

    init(article: FormattedArticle) {
        self.formattedArticle = article
    }
}
