import UIKit

class ArticleCell: UICollectionViewCell {

    private var viewModel: ArticleCellViewModeling?

    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = UIColor.licorice
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let font = "Georgia-Bold"

    lazy var articleTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: font, size: 20)
        label.textAlignment = .left
        label.textColor = .licorice
        label.backgroundColor = .clear
        label.numberOfLines = 0
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

    func updateWith(article: Article) {
        viewModel = ArticleCellViewModel(article: article)
        self.articleTitleLabel.text = self.viewModel?.titleString

        DispatchQueue.global().async {
            guard let imageString = self.viewModel?.urlString else { return }
            if let url = URL(string: imageString) {
                do {
                    if let data = try? Data(contentsOf: url) {
                        let image = UIImage(named: "no_image")?.withRenderingMode(.alwaysTemplate)

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            self.articleImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.viewModel?.heightMultiplier ?? 0.6)
                            self.articleImageView.image = UIImage(data: data) ?? image
//                            self.articleTitleLabel.text = self.viewModel?.titleString
                        })
//                        DispatchQueue.main.async {
//                            self.articleImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.viewModel?.heightMultiplier ?? 0.6)
//                            self.articleImageView.image = UIImage(data: data) ?? image
//                            self.titleLabel.text = self.viewModel?.title
//                        }
                    }
                }
            }
        }
    }
}
