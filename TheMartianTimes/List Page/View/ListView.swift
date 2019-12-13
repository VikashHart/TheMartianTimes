import UIKit

class ListView: UIView {

    lazy var backgroundGradient: GradientView = GradientView.makeGradientView()

    lazy var headerViewContainer: UIView = UIView.makeContainerView()

    lazy var headerLabel: UILabel = UILabel.makeHeaderLabel()

    lazy var segmentedControl: UISegmentedControl = UISegmentedControl.makeSegmentedControl()

    lazy var collectionView: UICollectionView = UICollectionView.makeCollectionView(with: ArticleCell.self, scrollDirection: .vertical, frame: frame, and: StaticAppStrings.Cells.articleCell)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }

    private func setupViews() {
        setupBackgroundGradient()
        setupHeaderViewContainer()
        setupHeaderLabel()
        setupSegmentedControl()
        setupCollectionView()
    }

    private func setupBackgroundGradient() {
        addSubview(backgroundGradient)
        NSLayoutConstraint.activate([
            backgroundGradient.topAnchor.constraint(equalTo: topAnchor),
            backgroundGradient.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundGradient.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundGradient.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    private func setupHeaderViewContainer() {
        addSubview(headerViewContainer)
        NSLayoutConstraint.activate([
            headerViewContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerViewContainer.heightAnchor.constraint(equalToConstant: 44)
            ])
    }

    private func setupHeaderLabel() {
        headerViewContainer.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: headerViewContainer.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: headerViewContainer.centerYAnchor),
            headerLabel.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

    private func setupSegmentedControl() {
        addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: headerViewContainer.bottomAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
    }

    private func setupCollectionView() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
