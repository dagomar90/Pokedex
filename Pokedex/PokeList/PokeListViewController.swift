import UIKit

class PokeListViewController: UIViewController {
    private let viewModel: PokeListViewModel
    private lazy var collectionView: PokeListCollectionView = {
        PokeListCollectionView.setup(delegate: self,
                                     dataSource: self,
                                     size: view.frame.size)
    }()
    
    init(viewModel: PokeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init with coder is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscribeToViewModel()
        
        view.addSubview(collectionView)
        collectionView.anchor(to: view)
        load()
    }
        
    private func subscribeToViewModel() {
        viewModel.onUpdate = { [weak self] in self?.onUpdate() }
        viewModel.onError = { [weak self] in self?.onError($0) }
        viewModel.onSelect = { [weak self] in self?.onSelect($0) }
    }
    
    private func onUpdate() {
        collectionView.reloadData()
    }
    
    private func onError(_ error: Error) {
        
    }
    
    private func onSelect(_ pokemon: PokePreview) {
        navigationController.map({ viewModel.navigateToDetail(preview: pokemon, presenter: $0) })
    }
    
    private func load() {
        viewModel.load()
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
    }
}
