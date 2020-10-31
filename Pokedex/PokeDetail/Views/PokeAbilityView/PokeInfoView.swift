import UIKit

class PokeInfoView: UIView {
    let viewModel: PokeInfoViewModel
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.spacing = 8
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
        
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
        
    init(viewModel: PokeInfoViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        addSubview(verticalStack)
        verticalStack.anchor(to: self)
        
        verticalStack.addArrangedSubview(titleLabel)
        onUpdate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init with coder is not supported")
    }
    
    private func onUpdate() {
        titleLabel.text = viewModel.title
        viewModel
            .pokeInfoRowViewModels
            .map(PokeInfoRowView.init)
            .forEach(verticalStack.addArrangedSubview)
    }
}
