import UIKit

extension UIColor {
    convenience init? (hexString: String) {
        let hexString = hexString.trimmingCharacters(in: CharacterSet.punctuationCharacters)
        let filteredStr = hexString.filter{"aAbBcCdDeEfF0123456789".contains($0)}

        guard hexString.count == filteredStr.count, hexString.count == 6 else {
            return nil
        }

        let positionR = hexString.index(hexString.startIndex, offsetBy: 2)
        let positionG = hexString.index(hexString.startIndex, offsetBy: 4)

        guard let r = Double("0x" + hexString[..<positionR]),
            let g = Double("0x" + hexString[positionR..<positionG]),
            let b = Double("0x" + hexString[positionG...]) else { return nil }

        self.init(red:   CGFloat(r / 255),
                  green: CGFloat(g / 255),
                  blue:  CGFloat(b / 255),
                  alpha: 1)
    }
}

extension UIColor {
    // Black
    static let lightBlack = UIColor(hexString: "434343")!
    static let licorice   = UIColor(hexString: "121113")!
    // Gray
    static let stone  = UIColor(hexString: "868f96")!
    static let cloudy = UIColor(hexString: "d7d2cc")!
    static let fog    = UIColor(hexString: "ebedee")!
}

extension CGColor {
    static let blacks  = [UIColor.licorice.cgColor, UIColor.black.cgColor]
    static let grays   = [UIColor.cloudy.cgColor, UIColor.stone.cgColor]
    static let whites  = [UIColor.white.cgColor, UIColor.fog.cgColor]
}
