import Quick
import Nimble
@testable import TheMartianTimes

class TranslatorSpec: QuickSpec {

    override func spec() {
        var translator: Translatable!
        var formattedArticle: FormattedArticle!
        var translatedArticle: FormattedArticle!

        describe("Language Translator") {
            context("After translator is initialized with Article text") {

                beforeEach {
                    formattedArticle = TranslatedArticle(title: "Facebook plans to raise $10.6 billion in mega IPO ", body: "The eight-year-old social network that began as Mark Zuckerberg's Harvard dorm room project", imageURL: URL(string: "testString"), heightMultiplier: 0.6)
                    translator = Translator()

                    translatedArticle = translator.translateArticle(article: formattedArticle)
                }

                it("translated article title should translate to 'Boinga boinga to boinga $10.6 boinga in boinga IPO '") {
                    expect(translatedArticle.title).to(equal("Boinga boinga to boinga $10.6 boinga in boinga IPO "))
                }
                
                it("translated article body should translate to 'The boinga boinga boinga boinga boinga as Boinga Boinga Boinga boinga boinga boinga'") {
                    expect(translatedArticle.body).to(equal("The boinga boinga boinga boinga boinga as Boinga Boinga Boinga boinga boinga boinga"))
                }
            }

            context("After the translator is initialized with edge case text") {

                beforeEach {
                    formattedArticle = TranslatedArticle(title: "Blue Blue? ?Blue ?Blue? Bl2ue Bl2ue? ?Bl2ue ?Bl2ue? Blu'e Blu'e? ?Blu'e ?Blu'e? blue blue? ?blue ?blue? bl2ue bl2ue? ?bl2ue ?bl2ue? blu'e blu'e? ?blu'e ?blu'e? blu blu? ?blu ?blu?", body: "2000 2000.0 2,000 2,000.0 $2000 $2000.0 $2,000 $2,000.0 2000¢ 2,000¢ 2000.0¢ 2,000.0¢ $2000¢ $2,000¢ $2000.0¢ $2,000.0¢ 2000q 200q00 $2000q", imageURL: URL(string: "testString"), heightMultiplier: 0.6)
                    translator = Translator()

                    translatedArticle = translator.translateArticle(article: formattedArticle)
                }

                it("translated article title should translate to 'Boinga Boinga? ?Boinga ?Boinga? Boinga Boinga? ?Boinga ?Boinga? Boinga Boinga? ?Boinga ?Boinga? boinga boinga? ?boinga ?boinga? boinga boinga? ?boinga ?boinga? boinga boinga? ?boinga ?boinga? blu blu? ?blu ?blu?'") {
                    expect(translatedArticle.title).to(equal("Boinga Boinga? ?Boinga ?Boinga? Boinga Boinga? ?Boinga ?Boinga? Boinga Boinga? ?Boinga ?Boinga? boinga boinga? ?boinga ?boinga? boinga boinga? ?boinga ?boinga? boinga boinga? ?boinga ?boinga? blu blu? ?blu ?blu?"))
                }

                it("translated article body should translate to '2000 2000.0 2,000 2,000.0 $2000 $2000.0 $2,000 $2,000.0 2000¢ 2,000¢ 2000.0¢ 2,000.0¢ $2000¢ $2,000¢ $2000.0¢ $2,000.0¢ boinga boinga $boinga'") {
                    expect(translatedArticle.body).to(equal("2000 2000.0 2,000 2,000.0 $2000 $2000.0 $2,000 $2,000.0 2000¢ 2,000¢ 2000.0¢ 2,000.0¢ $2000¢ $2,000¢ $2000.0¢ $2,000.0¢ boinga boinga $boinga"))
                }
            }
        }
    }
}
