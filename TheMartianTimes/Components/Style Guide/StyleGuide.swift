import UIKit

enum StyleGuide {
    enum AppColors {
        static let gradientColors = CGColor.whites
        static let primaryColor = UIColor.licorice
        static let secondaryColor = UIColor.lightBlack
    }

    enum Fonts {
        private static let standardFont = "Georgia"
        private static let boldFont = "Georgia-Bold"
        static let headerFont = UIFont(name: Fonts.boldFont, size: 24)
        static let titleFont = UIFont(name: Fonts.boldFont, size: 20)
        static let bodyFont = UIFont(name: Fonts.standardFont, size: 18)
        static let segmentedControllerFont = UIFont(name: Fonts.standardFont, size: 20)
        static let refreshTitleFont = UIFont(name: Fonts.standardFont, size: 18)!
    }

    enum StaticText {
        static let headerText = "The Martian Times"
        static let segmentOne = "English"
        static let segmentTwo = "Martian"
        static let refreshText = "Fetching News Data ..."
        static let alertControlErrorText = "An error occured while fetching data."
        static let alertControlConfirmationText = "Ok"
        static let alertControlRetryText = "Try Again"
    }

    enum ImageAssets {
        static let backButtonImage = "back_button"
        static let noImageAvailable = "no_image"
    }

    enum Cells {
        static let articleCell = "ArticleCell"
    }
}
