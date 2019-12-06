import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ListViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func dismiss() {
        navigationController.popViewController(animated: true)
    }

    func presentArticlePage(article: FormattedArticle) {
        let vc = ArticleViewController(article: article)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
