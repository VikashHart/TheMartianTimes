import Foundation

typealias Articles = [Article]

struct Article: Codable {
    let title: String
    let images: [Image]
    let body: String
}

struct Image: Codable {
    let topImage: Bool
    let url: String
    let width: Int
    let height: Int

    enum CodingKeys: String, CodingKey {
        case topImage = "top_image"
        case url
        case width
        case height
    }
}
