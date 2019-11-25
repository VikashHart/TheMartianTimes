import UIKit

protocol ArticleCellViewModeling {
    var urlString: String? { get }
    var titleString: String { get }
    var heightMultiplier: CGFloat { get }
}

class ArticleCellViewModel: ArticleCellViewModeling {

    var urlString: String?
    var titleString: String
    var heightMultiplier: CGFloat = 0.6

    init(article: Article) {
        self.titleString = article.title
        getImageAndMultiplier(imageStrings: article.images)
    }

    private func getImageAndMultiplier(imageStrings: [Image]){
        DispatchQueue.global().async {
            var width = Int()
            var height = Int()

            for image in imageStrings {
                if image.topImage != false {
                    self.urlString = image.url
                    width = image.width
                    height = image.height
                }
            }

            self.heightMultiplier = (CGFloat(height) / CGFloat(width))

//            if let url = URL(string: imageURL) {
//                do {
//                    if let data = try? Data(contentsOf: url) {
//                        let image = UIImage(named: "no_image")?.withRenderingMode(.alwaysTemplate)
//
//                        DispatchQueue.main.async {
//                            self.image = UIImage(data: data) ?? image
//                        }
//                    }
//                }
//            }
        }
    }
}
