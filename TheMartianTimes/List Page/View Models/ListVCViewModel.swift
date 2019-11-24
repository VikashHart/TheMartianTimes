import UIKit

protocol ListVCViewModeling {
    var cellSpacing: CGFloat { get }
    var numberOfCells: CGFloat { get }
    var numberOfSpaces: CGFloat { get }
    var articles: [Article] { get }
    var onDataRecieved: (() -> Void)? { get set }

    func loadInitialData()
}

class ListVCViewModel: ListVCViewModeling {

    let cellSpacing: CGFloat
    let numberOfCells: CGFloat
    let numberOfSpaces: CGFloat
    private (set) var articles: [Article] = [] {
        didSet {
            DispatchQueue.main.async {
                self.onDataRecieved?()
            }
        }
    }

    var onDataRecieved: (() -> Void)?

    init(cellSpacing: CGFloat = 10, numberOfCells: CGFloat = 1) {
        self.cellSpacing = cellSpacing
        self.numberOfCells = numberOfCells
        self.numberOfSpaces = numberOfCells + 1

    }

    func loadInitialData() {

    }
}
