import UIKit

class PokeListTableViewCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                                     label.topAnchor.constraint(equalTo: contentView.topAnchor)])
        return label
    }()
        
    func setup(viewModel: PokeListCellViewModel) {
        titleLabel.text = viewModel.name
    }
}
