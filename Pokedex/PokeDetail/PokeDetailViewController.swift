import UIKit

class PokeDetailViewController: UIViewController {
    let viewModel: PokeDetailViewModel
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var heightLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var weightLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var baseExperienceLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var mainScrollView: UIScrollView = {
        UIScrollView()
    }()
    
    private lazy var imagesScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    private lazy var imagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = .leading
        return stackView
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
        
        setupLayout()
        bindToViewModel()
        viewModel.load()
    }
    
    private func setupLayout() {
        view.addSubview(contentView)
        contentView.anchor(to: view)
        
        imagesScrollView.addSubview(imagesStackView)
        imagesStackView.anchor(to: imagesScrollView)
        imagesStackView.heightAnchor.constraint(equalTo: imagesScrollView.heightAnchor).isActive = true
        
        mainScrollView.addSubview(imagesScrollView)
        imagesScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imagesScrollView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
                                     imagesScrollView.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor),
                                     imagesScrollView.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor),
                                     imagesScrollView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor),
                                     imagesScrollView.widthAnchor.constraint(equalTo: imagesScrollView.heightAnchor)])
        
        [nameLabel,
         heightLabel,
         weightLabel,
         baseExperienceLabel].forEach({ verticalStack.addArrangedSubview($0) })
        
        mainScrollView.addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([verticalStack.topAnchor.constraint(equalTo: imagesScrollView.bottomAnchor),
                                     verticalStack.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
                                     verticalStack.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor),
                                     verticalStack.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor)])
        
        verticalStack.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor).isActive = true
        
        contentView.addSubview(mainScrollView)
        mainScrollView.anchor(to: contentView)
    }
    
    private func bindToViewModel() {
        viewModel.onUpdate = { [weak self] in self?.onUpdate() }
        viewModel.onError = { [weak self] in self?.onError($0) }
    }
    
    private func onUpdate() {
        nameLabel.text = viewModel.name
        baseExperienceLabel.text = viewModel.baseExperience
        weightLabel.text = viewModel.weight
        heightLabel.text = viewModel.height
        
        let images = viewModel
            .images
            .map({ PokeImageViewModel(url: $0, network: viewModel.network) })
            .map(PokeImageView.init)
            
        images.forEach({ image in
            imagesStackView.addArrangedSubview(image)
            image.widthAnchor.constraint(equalTo: imagesScrollView.widthAnchor).isActive = true
            image.heightAnchor.constraint(equalTo: imagesScrollView.heightAnchor).isActive = true
        })
    }
    
    private func onError(_ error: Error) {
        
    }
}
