import UIKit

extension UISegmentedControl {
    static func makeSegmentedControl() -> UISegmentedControl{
        let sc = UISegmentedControl(items: [StyleGuide.StaticText.segmentOne, StyleGuide.StaticText.segmentTwo])
        let fontStyle = StyleGuide.Fonts.segmentedControllerFont
        sc.setTitleTextAttributes([NSAttributedString.Key.font: fontStyle!],
                                  for: .normal)
        sc.selectedSegmentIndex = 0
        sc.backgroundColor = .clear
        sc.tintColor = StyleGuide.AppColors.secondaryColor
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }
}
