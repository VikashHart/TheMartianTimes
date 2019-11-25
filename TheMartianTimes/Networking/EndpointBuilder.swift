import Foundation

class EndpointBuilder {
    static private let urlString = "https://s1.nyt.com/ios-newsreader/candidates/test/articles.json"

    static func getEndpointURL() -> URL {
        guard let url = URL(string: urlString) else
        { fatalError("could not generate valid URL") }
        return url
    }
}
