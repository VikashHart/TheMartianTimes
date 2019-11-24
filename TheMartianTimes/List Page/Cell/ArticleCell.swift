import UIKit

class ArticleCell: UICollectionViewCell {

    private var viewModel: ArticleCellViewModeling?

    lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let font = "AvenirNext-Regular"

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: font, size: 24)
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.textColor = .white
        label.backgroundColor = .clear
        label.layer.borderColor = UIColor.lightBlack.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 10
        label.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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
        setupImageView()
        setupTitleLabel()
    }

    private func setupImageView() {
        addSubview(articleImageView)
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: topAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            articleImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6)
            ])
    }

    private func setupTitleLabel() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10)
            ])
    }

    func updateWith(article: Article) {
        viewModel = ArticleCellViewModel(article: article)
        articleImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: viewModel?.heightMultiplier ?? 0.6)
        articleImageView.image = viewModel?.image
        titleLabel.text = viewModel?.title
    }
}
