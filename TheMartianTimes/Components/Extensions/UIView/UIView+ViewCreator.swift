import UIKit

extension UIView {
    static func makeContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    static func makeGradientView() -> GradientView {
        let view = GradientView()
        view.gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
        view.gradientLayer?.endPoint = CGPoint(x: 1, y: 1)
        view.gradientLayer?.colors = StyleGuide.AppColors.gradientColors
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
