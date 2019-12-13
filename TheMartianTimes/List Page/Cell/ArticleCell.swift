import UIKit

class ArticleCell: UICollectionViewCell {

    private var viewModel: ArticleCellViewModeling?

    lazy var containerView: UIView = UIView.makeContainerView()

    lazy var articleImageView: UIImageView = UIImageView.makeImageView()

    lazy var articleTitleLabel: UILabel = UILabel.makeTitleLabel()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        configureCell()
        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func configureCell() {
        backgroundColor = UIColor.white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10

    }

    private func setupViews() {
        setupContainer()
        setupImageView()
        setupArticleTitleLabel()
    }

    private func setupContainer() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    private func setupImageView() {
        containerView.addSubview(articleImageView)
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6)
            ])
    }

    private func setupArticleTitleLabel() {
        containerView.addSubview(articleTitleLabel)
        NSLayoutConstraint.activate([
            articleTitleLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant:  5),
            articleTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant:  20),
            articleTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:  -20),
            articleTitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant:  -5)
            ])
    }

    public func updateWith(article: FormattedArticle) {
        viewModel = ArticleCellViewModel(article: article)
        getImage(for: article) { [weak self] image in
            self?.articleTitleLabel.text = article.title
            self?.articleImageView.heightAnchor.constraint(equalTo: self!.widthAnchor, multiplier: article.imageHeightMultiplier)
            self?.articleImageView.image = image
        }
    }

    public func getArticle() -> FormattedArticle {
        return viewModel!.formattedArticle
    }

    private func getImage(for article: FormattedArticle, completion: @escaping (UIImage) -> Void) {
            guard let url = article.imageURL else { return }

            do {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        ImageCache.shared.cacheImage(with: url, for: image)
                        completion(image)
                    } else if let noImage = UIImage(named: StaticAppStrings.ImageAssets.noImageAvailable) {
                        completion(noImage)
                }
            }
        }
    }
}
