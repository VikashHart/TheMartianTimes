import UIKit

extension Article: FormattedArticle {

    var topImage: Image? {
        return self.images.filter({ (image) -> Bool in
            return image.topImage == true
        })
        .first
    }
    
    var imageURL: URL? {
        guard let image = topImage else { return nil }
        return URL(string: image.url)
    }

    var imageHeightMultiplier: CGFloat {
        guard let image = topImage else { return 0.6 }
        return CGFloat(image.height) / CGFloat(image.width)
    }
}
