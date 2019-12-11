import UIKit

struct TranslatedArticle: FormattedArticle {
    var title: String

    var imageURL: URL?

    var heightMultiplier: CGFloat

    var body: String

    init(title: String, body: String, imageURL: URL?, heightMultiplier: CGFloat) {
        self.title = title
        self.body = body
        self.imageURL = imageURL
        self.heightMultiplier = heightMultiplier
    }
}
