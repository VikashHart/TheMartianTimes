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

    lazy var settingsButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "settings_button")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.layer.opacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

//    let font = "AvenirNext-Regular"
    let font = "Georgia-Bold"

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "The Martian Times"
        label.font = UIFont(name: font, size: 24)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        setupSettingsButton()
        setupHeaderLabel()
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

    private func setupSettingsButton() {
        headerViewContainer.addSubview(settingsButton)
        NSLayoutConstraint.activate([
            settingsButton.centerYAnchor.constraint(equalTo: headerViewContainer.centerYAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: headerViewContainer.trailingAnchor, constant: -10),
            settingsButton.heightAnchor.constraint(equalToConstant: 28),
            settingsButton.widthAnchor.constraint(equalToConstant: 28)
            ])
    }

    private func setupHeaderLabel() {
        headerViewContainer.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: headerViewContainer.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: headerViewContainer.centerYAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: settingsButton.leadingAnchor, constant: 10),
            headerLabel.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

    private func setupCollectionView() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerViewContainer.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
