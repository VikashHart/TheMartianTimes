import UIKit

protocol FormattedArticle {
    var title: String { get }
    var imageURL: URL? { get }
    var imageHeightMultiplier: CGFloat { get }
    var body: String { get }
}
