import UIKit
import Quick
import Nimble
@testable import TheMartianTimes

private class MockApiClient: ArticleRetrievable {
    func getArticles(completion: @escaping (Result<[FormattedArticle], NetworkError>) -> Void) {
        completion(.success([TranslatedArticle(title: "Test title", body: "Test body", imageURL: URL(string: "TestUrl"), heightMultiplier: 0.6)]))
    }
}

class ListVCViewModelSpec: QuickSpec {

    override func spec() {
        var viewModel: ListVCViewModeling!
        var onDataRecieved: (() -> Void)!
        var onErrorRecieved: (() -> Void)!
        var didRecieveData: Bool!
        var didRecieveError: Bool!

        describe("ListVCViewModel") {
            context("When the ListVCViewModel is initialized") {

                beforeEach {
                    viewModel = ListVCViewModel(apiClient: MockApiClient(), currentLanguage: .english)

                    onDataRecieved = {
                        didRecieveData = true
                    }

                    onErrorRecieved = {
                        didRecieveError = true
                    }

                    viewModel.onDataRecieved = onDataRecieved
                    viewModel.onDataRecieved?()

                    viewModel.onErrorRecieved = onErrorRecieved
                    viewModel.onErrorRecieved?()

                    viewModel.loadInitialData()
                }

                it("didRecieveData should be true") {
                    expect(didRecieveData).to(be(true))
                }

                it("didRecieveError should be true") {
                    expect(didRecieveError).to(be(true))
                }

                it("articles.count should be 1") {
                    expect(viewModel.articles.count).to(be(1))
                }
            }
        }
    }
}
