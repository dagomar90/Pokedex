import UIKit

class PokeListViewController: UIViewController {
    private let viewModel = PokeListViewModel()
    private lazy var collectionView: PokeListCollectionView = {
        PokeListCollectionView.setup(delegate: self,
                                dataSource: self)
    }()
    
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
        print("selecting \(pokemon.name)")
    }
    
    private func load() {
        viewModel.load()
    }
}

extension UIView {
    func anchor(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topAnchor.constraint(equalTo: view.topAnchor),
                                     bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     leftAnchor.constraint(equalTo: view.leftAnchor),
                                     rightAnchor.constraint(equalTo: view.rightAnchor)])
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

extension PokeListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.size.width / 2 - 16, height: 200)
    }
}
