import UIKit

class PokeListSearchBarView: UIView {
    private let viewModel: PokeListSearchBarViewModel
    
    private lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = viewModel.placeholder
        textField.font = UIFont(name: "Signika-Light", size: 17)
        textField.backgroundColor = UIColor.white
        textField.delegate = self
        textField.clearButtonMode = .whileEditing
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    private lazy var goButton: UIButton = {
        let button = UIButton()
        button.setTitle(viewModel.goButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: "Signika-Light", size: 17)
        button.addTarget(self, action: #selector(goAction), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: PokeListSearchBarViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        addSubview(horizontalStack)
        horizontalStack.anchor(to: self, margin: 16)
        
        let view = UIView()
        view.addSubview(textField)
        textField.anchor(to: view)
        
        horizontalStack.addArrangedSubview(view)
        horizontalStack.addArrangedSubview(goButton)
        
        subscribeToViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init with coder is not supported")
    }
    
    private func subscribeToViewModel() {
        viewModel.onSearchBarUpdates = { [weak self] in self?.restoreSearchBar() }
        viewModel.onTextFieldShouldReturn = { [weak self] in
            self?.goAction()
            self?.dismissKeyboard()
        }
        viewModel.onScroll = { [weak self] in self?.dismissKeyboard() }
        viewModel.onPokemonSelection = { [weak self] in self?.dismissKeyboard() }
    }
    
    private func restoreSearchBar() {
        dismissKeyboard()
        textField.text = ""
    }
        
    private func dismissKeyboard() {
        textField.resignFirstResponder()
    }
}

extension PokeListSearchBarView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return viewModel.textFieldShouldReturn()
    }
}

extension PokeListSearchBarView {
    @objc private func goAction() {
        viewModel.goAction(name: textField.text.orEmpty)
    }
}
