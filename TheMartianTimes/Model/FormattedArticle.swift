import UIKit

protocol FormattedArticle {
    var title: String { get }
    var imageURL: URL? { get }
    var heightMultiplier: CGFloat { get }
    var body: String { get }
}
