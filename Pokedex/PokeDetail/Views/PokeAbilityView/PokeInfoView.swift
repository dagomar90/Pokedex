import UIKit

class PokeInfoView: UIView {
    let viewModel: PokeInfoViewModel
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.spacing = 8
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.spacing = 8
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var scrollView: UIScrollView = {
        UIScrollView()
    }()
        
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Signika-Light", size: 16)
        return label
    }()
        
    init(viewModel: PokeInfoViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        addSubview(verticalStack)
        verticalStack.anchor(to: self)
        
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(horizontalStack)
        onUpdate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init with coder is not supported")
    }
    
    private func onUpdate() {
        titleLabel.text = viewModel.title
        viewModel
            .pokeInfoRowViewModels
            .map(PokeSlotView.init)
            .forEach(horizontalStack.addArrangedSubview)
    }
}
