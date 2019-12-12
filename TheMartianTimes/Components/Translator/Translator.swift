import Foundation

class Translator {
    private let valid = CharacterSet.alphanumerics

    func translateArticle(article: FormattedArticle) -> FormattedArticle {
        return TranslatedArticle(title: englishToMartian(words: article.title), body: englishToMartian(words: article.body), imageURL: article.imageURL, heightMultiplier: article.heightMultiplier)
    }

    private func englishToMartian(words: String) -> String {
        var allWords = ""
        let cleanedWords = words.replacingOccurrences(of: "\n", with: " \n")
        let wordArray = cleanedWords.components(separatedBy: .whitespaces)

        for word in wordArray {
            let translatedWord = translateWordToMartian(from: String(word))

            if word == wordArray.last {
                allWords.append("\(translatedWord)")
            } else {
                allWords.append("\(translatedWord)" + " ")
            }
        }
        return allWords
    }

    private func translateWordToMartian(from word: String) -> String {

        guard let firstLetterIndex = word.firstIndex(where: {valid.containsUnicodeScalars(of: $0)}),
            let lastLetterIndex = word.lastIndex(where: {valid.containsUnicodeScalars(of: $0)})
            else { return word }

        let translatable = word[firstLetterIndex...lastLetterIndex]

        guard translatable.count > 3 else { return word }

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