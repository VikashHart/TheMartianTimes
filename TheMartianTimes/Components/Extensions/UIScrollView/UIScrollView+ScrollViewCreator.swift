import UIKit

extension UIScrollView {
    static func makeScrollView() -> UIScrollView {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        sv.delaysContentTouches = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }
}
