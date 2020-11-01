import UIKit

class PokeListCollectionView: UICollectionView {
    static func setup(delegate: UICollectionViewDelegate? = nil,
                      dataSource: UICollectionViewDataSource? = nil,
                      size: CGSize) -> PokeListCollectionView {
        let collectionView = PokeListCollectionView(frame: .zero,
                                                    collectionViewLayout: CustomLayout(size: size))
        collectionView.backgroundColor = UIColor(named: "Background")
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PokeListCollectionViewCell.self, forCellWithReuseIdentifier: "\(PokeListCollectionViewCell.self)")
        
        return collectionView
    }
}

class CustomLayout: UICollectionViewFlowLayout {
    init(size: CGSize) {
        super.init()
        let numColumns = CGFloat(Int(size.width) / 160)
        itemSize = CGSize(width: size.width / numColumns - 12, height: 160)
        minimumInteritemSpacing = 8
        sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let numColumns = CGFloat(Int(newBounds.width) / 160)
        self.itemSize = CGSize(width: newBounds.width / numColumns - 12, height: 160)
        return true
    }
}
