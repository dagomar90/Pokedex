import UIKit

class PokeListViewController: UIViewController {
    private let viewModel: PokeListViewModel
    private lazy var collectionView: PokeListCollectionView = {
        PokeListCollectionView.setup(delegate: self,
                                     dataSource: self,
                                     size: view.frame.size)
    }()
    
    private lazy var searchBar: PokeListSearchBarView = {
        let view = PokeListSearchBarView(viewModel: viewModel.searchBarViewModel)
        view.backgroundColor = UIColor(named: "Background")
        return view
    }()
    
    init(viewModel: PokeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init with coder is not supported")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.bounds = CGRect(origin: .zero, size: size)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscribeToViewModel()
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([searchBar.topAnchor.constraint(equalTo: view.topAnchor),
                                     searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor)])
        load()
    }
        
    private func subscribeToViewModel() {
        viewModel.onUpdate = { [weak self] in self?.onUpdate(indexPaths: $0) }
        viewModel.onError = { [weak self] in self?.onError($0) }
        viewModel.onSelect = { [weak self] in self?.onSelect($0) }
        viewModel.searchBarViewModel.onGo = { [weak self] in self?.onSearchBarGo(name: $0, url: $1) }
    }
    
    private func onUpdate(indexPaths: [IndexPath]) {
        collectionView.insertItems(at: indexPaths)
    }
    
    private func onError(_ error: Error) {
        UIAlertController.show(error: error,
                               in: self,
                               retry: { self.load() },
                               cancel: { })
    }
    
    private func onSelect(_ pokemon: PokePreview) {
        navigationController.map({ viewModel.navigateToDetail(preview: pokemon, presenter: $0) })
    }
    
    private func load() {
        viewModel.load()
    }
    
    private func onSearchBarGo(name: String, url: String) {
        onSelect(PokePreview(name: name, url: url))
    }
}

extension UIView {
    func anchor(to view: UIView, margin: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topAnchor.constraint(equalTo: view.topAnchor, constant: margin),
                                     bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin),
                                     leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin),
                                     rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin)])
    }
}

extension PokeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PokeListCollectionViewCell.self)", for: indexPath) as? PokeListCollectionViewCell
        cell?.setup(viewModel: viewModel.viewModels[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.loadNext(indexPath)
    }
}

extension PokeListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.viewModels[indexPath.row].select()
        viewModel.searchBarViewModel.pokemonSelected()
    }
}

extension PokeListViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        viewModel.searchBarViewModel.scroll()
    }
}
