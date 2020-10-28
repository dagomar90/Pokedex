import UIKit

class PokeListCollectionViewCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                     label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)])
        return label
    }()
    
    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                                     imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                                     imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
                                     imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -16)])
        return imageView
    }()
    
    private var viewModel: PokeListCellViewModel?
    
    func setup(viewModel: PokeListCellViewModel) {
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 5.0
        contentView.layer.masksToBounds = true

        titleLabel.text = viewModel.name
        
        self.viewModel = viewModel
        self.viewModel?.onFailure = { [weak self] in self?.onError($0) }
        self.viewModel?.onSuccess = { [weak self] in self?.imageDownloaded($0) }
        self.viewModel?.loadImage()
    }
    
    private func imageDownloaded(_ data: Data) {
        previewImageView.image = UIImage(data: data)
    }
    
    private func onError(_ error: Error) {
        print("error \(error)")
    }
}
