import UIKit

class PokeDetailViewController: UIViewController {
    let viewModel: PokeDetailViewModel
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    init(viewModel: PokeDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init with coder is not supported")
    }
}

extension PokeDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(contentView)
        contentView.anchor(to: view)
    }
}
