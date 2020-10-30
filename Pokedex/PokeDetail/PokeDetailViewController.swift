import UIKit

class PokeDetailViewController: UIViewController {
    let viewModel: PokeDetailViewModel
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Background")
        return view
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
        
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: "Signika-SemiBold", size: 22)
        return label
    }()
    
    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: "Signika-Light", size: 16)
        return label
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: "Signika-Light", size: 16)
        return label
    }()
    
    private lazy var baseExperienceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: "Signika-Light", size: 16)
        return label
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
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var imagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var imagesPageControl: UIPageControl = {
        UIPageControl()
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
        
        contentView.addSubview(backgroundView)
        backgroundView.layer.cornerRadius = 5
        backgroundView.layer.masksToBounds = true
        
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
        
        mainScrollView.addSubview(imagesPageControl)
        imagesPageControl.translatesAutoresizingMaskIntoConstraints = false
        imagesPageControl.bottomAnchor.constraint(equalTo: imagesScrollView.bottomAnchor, constant: -12).isActive = true
        imagesPageControl.centerXAnchor.constraint(equalTo: imagesScrollView.centerXAnchor).isActive = true
        
        contentView.addSubview(mainScrollView)
        mainScrollView.anchor(to: contentView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([backgroundView.topAnchor.constraint(equalTo: verticalStack.topAnchor),
                                     backgroundView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                                     backgroundView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
                                     backgroundView.bottomAnchor.constraint(equalTo: verticalStack.bottomAnchor)])
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
        
        imagesPageControl.numberOfPages = images.count
        imagesPageControl.currentPage = 0
        imagesPageControl.currentPageIndicatorTintColor = UIColor(named: "Background")
        imagesPageControl.pageIndicatorTintColor = .lightGray
        imagesPageControl.addTarget(self, action: #selector(pageControlValueChanged(_:)), for: .valueChanged)
    }
    
    private func onError(_ error: Error) {
        
    }
}

private extension PokeDetailViewController {
    @objc func pageControlValueChanged(_ sender: UIPageControl) {
        let xOffset = CGFloat(sender.currentPage) * imagesScrollView.frame.size.width
        imagesScrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
    }
}

extension PokeDetailViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView.frame.size.width > 0 else { return }
        imagesPageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
}
