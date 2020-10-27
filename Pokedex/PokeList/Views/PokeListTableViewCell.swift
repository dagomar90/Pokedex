import UIKit

class PokeListTableViewCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                                     label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
        return label
    }()
        
    func setup(viewModel: PokeListCellViewModel) {
        titleLabel.text = viewModel.name
    }
}
