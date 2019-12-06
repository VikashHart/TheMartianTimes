import UIKit

protocol ImageCaching {
    func getImage(for imageUrl: URL) -> UIImage?
    func cacheImage(with url: URL, for image: UIImage)
}

class ImageCache: ImageCaching {
    static let shared = ImageCache()
    private var imageCache: [URL: UIImage] = [:]

    func getImage(for imageUrl: URL) -> UIImage? {
        guard let image = imageCache[imageUrl]
            else { return nil }

        return image
    }

    func cacheImage(with url: URL, for image: UIImage) {
        if imageCache[url] != nil {
            // image already exists
        } else {
            imageCache[url] = image
        }
    }
}
