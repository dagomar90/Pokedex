import UIKit

class PokeImageView: UIImageView {
    let viewModel: PokeImageViewModel
    
    init(viewModel: PokeImageViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        contentMode = .scaleAspectFill
        subscribeToViewModel()
        viewModel.load()
    }
    
    private func subscribeToViewModel() {
        viewModel.onError = { [weak self] in self?.onError($0) }
        viewModel.onSuccess = { [weak self] in self?.onSuccess($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokeImageView {
    private func onSuccess(_ data: Data) {
        image = UIImage(data: data)
    }
    
    private func onError(_ error: Error) {
        
    }
}
