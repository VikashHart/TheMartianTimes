import Quick
import Nimble
@testable import TheMartianTimes

class ArticleCellViewModelSpec: QuickSpec {

    override func spec() {
        var viewModel: ArticleCellViewModeling!
        var article: FormattedArticle!

        beforeEach {
            article = TranslatedArticle(title: "Test article title", body: "Test article body", imageURL: URL(string: "https://www.nytimes.com"), heightMultiplier: 0.6)
            viewModel = ArticleCellViewModel(article: article)
        }

        it("view model article title should be 'Test article title'") {
            expect(viewModel.formattedArticle.title).to(equal("Test article title"))
        }

        it("view model article body should be 'Test article body'") {
            expect(viewModel.formattedArticle.body).to(equal("Test article body"))
        }

        it("view model article url should be 'https://www.nytimes.com'") {
            expect(viewModel.formattedArticle.imageURL?.absoluteString).to(equal("https://www.nytimes.com"))
        }

        it("view model article imageHeightMultiplier should be 0.6") {
            expect(viewModel.formattedArticle.imageHeightMultiplier).to(equal(0.6))
        }
    }
}

