import UIKit

class PokeImageView: UIView {
    let viewModel: PokeImageViewModel
    
    private lazy var imageView: UIImageView = {
        UIImageView()
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    init(viewModel: PokeImageViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        addSubview(backgroundView)
        backgroundView.anchor(to: self, margin: 16)
        backgroundView.layer.cornerRadius = 5
        backgroundView.layer.masksToBounds = true
        
        addSubview(imageView)
        imageView.anchor(to: self)
        
        imageView.contentMode = .scaleAspectFill
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
        imageView.image = UIImage(data: data)
    }
    
    private func onError(_ error: Error) {
        imageView.image = UIImage.init(named: "Placeholder")
    }
}
