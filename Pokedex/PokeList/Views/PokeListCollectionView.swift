import UIKit

class PokeListCollectionView: UICollectionView {
    static func setup(delegate: UICollectionViewDelegate? = nil,
                      dataSource: UICollectionViewDataSource? = nil) -> PokeListCollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        let collectionView = PokeListCollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor(named: "Background")
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PokeListCollectionViewCell.self, forCellWithReuseIdentifier: "\(PokeListCollectionViewCell.self)")
        
        return collectionView
    }
}
