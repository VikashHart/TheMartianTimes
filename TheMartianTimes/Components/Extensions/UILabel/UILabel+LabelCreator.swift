import UIKit

extension UILabel {
    static func makeHeaderLabel() -> UILabel {
        let label = UILabel()
        label.text = StaticAppStrings.StaticText.headerText
        label.font = StyleGuide.Fonts.headerFont
        label.textAlignment = .center
        label.textColor = StyleGuide.AppColors.primaryColor
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    static func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = StyleGuide.Fonts.titleFont
        label.textAlignment = .left
        label.textColor = StyleGuide.AppColors.primaryColor
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    static func makeBodyLabel() -> UILabel {
        let label = UILabel()
        label.font = StyleGuide.Fonts.bodyFont
        label.textAlignment = .left
        label.textColor = StyleGuide.AppColors.secondaryColor
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
