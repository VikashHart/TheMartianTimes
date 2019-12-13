import UIKit

class ArticleViewController: UIViewController {

    // Properties
    private let articleView = ArticleView()
    private var viewModel: ArticleVCViewModeling
    weak var coordinator: MainCoordinator?

    // Life-cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // Initializers
    init(article: FormattedArticle) {
        self.viewModel = ArticleVCViewModel(article: article)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // Private functions
    private func configureView() {
        view.backgroundColor = .white
        configureArticleViewConstraints()
        configureActions()
        articleView.updateUI(article: viewModel.article)
    }

    private func configureActions() {
        articleView.backButton.addTarget(self,
                                         action: #selector(dismissPage),
                                         for: .touchUpInside)
    }

    @objc private func dismissPage() {
        coordinator?.dismiss()
    }

    private func configureArticleViewConstraints() {
        articleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(articleView)
        NSLayoutConstraint.activate([
            articleView.topAnchor.constraint(equalTo: view.topAnchor),
            articleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            articleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            articleView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}
