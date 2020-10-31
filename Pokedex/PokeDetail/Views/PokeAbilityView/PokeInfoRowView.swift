import UIKit

class PokeInfoRowView: UIView {
    let viewModel: PokeInfoRowViewModel
        
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8
        stack.axis = .horizontal
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
        
    init(viewModel: PokeInfoRowViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        addSubview(stackView)
        stackView.anchor(to: self)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        onUpdate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init with coder is not supported")
    }
    
    private func onUpdate() {
        titleLabel.text = viewModel.key
        valueLabel.text = viewModel.value
    }
}
