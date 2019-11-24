import UIKit

protocol ArticleCellViewModeling {
    var image: UIImage? { get }
    var title: String { get }
    var heightMultiplier: CGFloat { get }
}

class ArticleCellViewModel: ArticleCellViewModeling {

    var image: UIImage?
    var title: String
    var heightMultiplier: CGFloat = 0.6

    init(article: Article) {
        self.title = article.title
        getImageAndMultiplier(imageStrings: article.images)
    }

    private func getImageAndMultiplier(imageStrings: [Image]){
        DispatchQueue.global().async {
            var imageURL = String()
            var width = Int()
            var height = Int()

            for image in imageStrings {
                if image.topImage != false {
                    imageURL = image.url
                    width = image.width
                    height = image.height
                }
            }

            if let url = URL(string: imageURL) {
                do {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self.image = UIImage(data: data) ?? UIImage(named: "no_image")!
                            self.heightMultiplier = (CGFloat(height) / CGFloat(width))
                        }
                    }
                }
            }
        }
    }
}
