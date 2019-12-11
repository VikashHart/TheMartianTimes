import UIKit

class ListViewController: UIViewController {

    private let listView = ListView()
    private var viewModel: ListVCViewModeling = ListVCViewModel()
    weak var coordinator: MainCoordinator?
    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureView()
        viewModel.loadInitialData()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    private func bindViewModel() {
        viewModel.onDataRecieved = { [weak self] in
            self?.listView.collectionView.reloadData()
        }

        viewModel.onErrorRecieved = { [weak self] in
            self?.presentErrorAlert()
        }
    }

    private func configureView() {
        view.backgroundColor = .white
        refreshControl.tintColor = UIColor.lightBlack
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching News Data ...", attributes: [NSAttributedString.Key.font: UIFont(name: "Georgia", size: 18.0)!, NSAttributedString.Key.foregroundColor: UIColor.lightBlack])
        listView.collectionView.delegate = self
        listView.collectionView.dataSource = self
        listView.collectionView.refreshControl = refreshControl
        configureListViewConstraints()
        configureActions()
        configureSegmentedController()
    }

    private func configureActions() {
        refreshControl.addTarget(self,
                                 action: #selector(refreshNewsData),
                                 for: UIControl.Event.valueChanged)
    }

    private func presentErrorAlert() {
        let alert = UIAlertController(title: "An error occured while fetching data.", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { action in
            self.viewModel.loadInitialData()
            self.dismiss(animated: true, completion: nil)
        }))

        self.present(alert, animated: true)
    }

    private func configureSegmentedController() {
        listView.segmentedController.selectedSegmentIndex = viewModel.selectedSegment
        listView.segmentedController.addTarget(self,
                                               action: #selector(indexChanged),
                                               for: UIControl.Event.valueChanged)
    }

    @objc private func refreshNewsData() {
        viewModel.loadInitialData()
        self.refreshControl.endRefreshing()
        self.activityIndicator.stopAnimating()
    }

    @objc private func indexChanged() {
        switch listView.segmentedController.selectedSegmentIndex {
        case 0:
            viewModel.currentLanguage = LanguageType.english
        case 1:
            viewModel.currentLanguage = LanguageType.martian
        default:
            viewModel.currentLanguage = LanguageType.english
        }
    }

    private func configureListViewConstraints() {
        listView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(listView)
        NSLayoutConstraint.activate([
            listView.topAnchor.constraint(equalTo: view.topAnchor),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = listView.collectionView.cellForItem(at: indexPath) as! ArticleCell
        let article = cell.getArticle()
        coordinator?.presentArticlePage(article: article)
    }
}

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.articles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as? ArticleCell else { return UICollectionViewCell() }
        let curentArticle = viewModel.articles[indexPath.row]
        cell.updateWith(article: curentArticle)
        return cell
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth - (viewModel.cellSpacing * viewModel.numberOfSpaces)) / viewModel.numberOfCells
        let height: CGFloat = width * 0.8
        return CGSize(width: width , height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: viewModel.cellSpacing, left: viewModel.cellSpacing, bottom: viewModel.cellSpacing, right: viewModel.cellSpacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.cellSpacing
    }
}
