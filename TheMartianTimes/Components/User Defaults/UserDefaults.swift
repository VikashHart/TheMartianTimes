import Foundation

protocol UserDefaulting {
    func saveActiveLanguage(setting: Int)
    func retrieveActiveLanguage() -> Int
}

class Defaults: UserDefaulting {
    private let languageKey = "currentLanguage"

    func saveActiveLanguage(setting: Int) {
        UserDefaults.standard.set(setting, forKey: languageKey)
    }

    func retrieveActiveLanguage() -> Int {
        return  UserDefaults.standard.integer(forKey: languageKey)
    }
}
