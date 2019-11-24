import UIKit

class ListViewController: UIViewController {

    private let listView = ListView()
    private var viewModel: ListVCViewModeling = ListVCViewModel()
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureView()
        viewModel.loadInitialData()
    }

    private func bindViewModel() {
        viewModel.onDataRecieved = { [weak self] in
            self?.listView.collectionView.reloadData()
        }
    }

    private func configureView() {
        view.backgroundColor = .white
        listView.collectionView.delegate = self
        listView.collectionView.dataSource = self
        configureListViewConstraints()
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
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let numCells: CGFloat = 3
//        let numSpaces: CGFloat = numCells + 1
//
//        let screenWidth = UIScreen.main.bounds.width
//        let screenHeight = UIScreen.main.bounds.height
//
//        return CGSize(width: (screenWidth - (viewModel.cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.25)
//    }

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
