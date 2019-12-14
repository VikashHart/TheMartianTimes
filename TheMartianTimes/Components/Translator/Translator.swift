import Foundation

protocol Translatable {
    func translateArticle(article: FormattedArticle) -> FormattedArticle
}

class Translator: Translatable {
    private let valid = CharacterSet.alphanumerics
    private let combinedSet = CharacterSet.decimalDigits.union(.punctuationCharacters).union(.symbols)

    func translateArticle(article: FormattedArticle) -> FormattedArticle {
        return TranslatedArticle(title: englishToMartian(words: article.title), body: englishToMartian(words: article.body), imageURL: article.imageURL, heightMultiplier: article.imageHeightMultiplier)
    }

    private func englishToMartian(words: String) -> String {
        return words.components(separatedBy: .newlines)
            .map { $0.components(separatedBy: .whitespaces)
                .map { translateWordToMartian(from: $0)}
                .joined(separator: " ")}
            .joined(separator: "\n")
    }

    private func translateWordToMartian(from word: String) -> String {

        guard let firstLetterIndex = word.firstIndex(where: {valid.containsUnicodeScalars(of: $0)}),
            let lastLetterIndex = word.lastIndex(where: {valid.containsUnicodeScalars(of: $0)})
            else { return word }

        let translatable = word[firstLetterIndex...lastLetterIndex]

        guard translatable.count > 3 && !combinedSet.isSuperset(of: CharacterSet(charactersIn: String(translatable))) else { return word }

        let prefix = word[word.startIndex..<firstLetterIndex]
        let suffix = word[word.index(after: lastLetterIndex)...]
        var boinga = ""

        if translatable.first?.isUppercase == true {
            boinga = "Boinga"
        } else {
            boinga = "boinga"
        }
        return prefix + boinga + suffix
    }
}
