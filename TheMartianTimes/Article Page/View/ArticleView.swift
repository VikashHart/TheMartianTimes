import UIKit

class ArticleView: UIView {

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

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back_button")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .licorice
        button.layer.opacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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

    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        sv.delaysContentTouches = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .lightBlack
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: boldFont, size: 18)
        label.textAlignment = .left
        label.textColor = .licorice
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let font = "Georgia"

    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: font, size: 18)
        label.textAlignment = .left
        label.textColor = .lightBlack
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        setupBackButton()
        setupHeaderLabel()
        setupScrollView()
        setupContainerView()
        setupArticleImageView()
        setupTitleLabel()
        setupBodyLabel()
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

    private func setupBackButton() {
        headerViewContainer.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: headerViewContainer.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: headerViewContainer.leadingAnchor, constant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 28),
            backButton.widthAnchor.constraint(equalToConstant: 28)
            ])
    }

    private func setupHeaderLabel() {
        headerViewContainer.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: headerViewContainer.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: headerViewContainer.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 10),
            headerLabel.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

    private func setupScrollView() {
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: headerViewContainer.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }

    private func setupContainerView() {
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            ])
    }

    private func setupArticleImageView() {
        contentView.addSubview(articleImageView)
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            articleImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            articleImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            articleImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
    }

    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
    }

    private func setupBodyLabel() {
        contentView.addSubview(bodyLabel)
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            bodyLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            ])
    }

    func updateUI(article: FormattedArticle) {
        articleImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: article.heightMultiplier)
        titleLabel.text = article.title
        bodyLabel.text = article.body
        if let url = article.imageURL {
            articleImageView.image = ImageCache.shared.getImage(for: url)
        } else if let noImage = UIImage(named: "no_image") {
            articleImageView.image = noImage
        }
    }
}
