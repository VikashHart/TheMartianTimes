import UIKit

class ListView: UIView {

    lazy var backgroundGradient: GradientView = {
        let view = GradientView()
        view.gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
        view.gradientLayer?.endPoint = CGPoint(x: 1, y: 1)
        view.gradientLayer?.colors = CGColor.whites
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var headerViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let boldFont = "Georgia-Bold"

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "The Martian Times"
        label.font = UIFont(name: boldFont, size: 24)
        label.textAlignment = .center
        label.textColor = .licorice
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let font = "Georgia"

    lazy var segmentedController: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["English", "Martian"])
        let fontStyle = UIFont(name: font, size: 20)
        sc.setTitleTextAttributes([NSAttributedString.Key.font: fontStyle!],
                                  for: .normal)
        sc.selectedSegmentIndex = 0
        sc.backgroundColor = .clear
        sc.tintColor = .lightBlack
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()

    let cell = "ArticleCell"

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: cell)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

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
        setupSegmentedController()
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

    private func setupSegmentedController() {
        addSubview(segmentedController)
        NSLayoutConstraint.activate([
            segmentedController.topAnchor.constraint(equalTo: headerViewContainer.bottomAnchor),
            segmentedController.leadingAnchor.constraint(equalTo: leadingAnchor),
            segmentedController.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
    }

    private func setupCollectionView() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: segmentedController.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
