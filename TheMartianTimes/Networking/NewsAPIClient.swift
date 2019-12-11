import Foundation

protocol ArticleRetrievable {
    func getArticles(completion: @escaping (Result<[FormattedArticle], NetworkError>) -> Void)
}

class NewsAPIClient: ArticleRetrievable {
    private let client: DataRetrieving

    init(dataRetriever: DataRetrieving = NetworkClient()) {
        self.client = dataRetriever
    }

    func getArticles(completion: @escaping (Result<[FormattedArticle], NetworkError>) -> Void) {
        getArticleData(request: URLRequest(url: EndpointBuilder.getEndpointURL()), completion: completion)
    }

    private func getArticleData(request: URLRequest,
                                completion: @escaping (Result<[FormattedArticle], NetworkError>) -> Void) {
        client.get(request: request) { (result) in
            switch result {
            case .success(let data):
                do {
                    let articleModel = try JSONDecoder().decode(Articles.self, from: data)
                    completion(.success(articleModel))
                } catch {
                    completion(.failure(NetworkError.jsonDecoding(error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
