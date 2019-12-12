import UIKit

extension UIButton {
    static func makeBackButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: StyleGuide.ImageAssets.backButtonImage)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = StyleGuide.AppColors.primaryColor
        button.layer.opacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
