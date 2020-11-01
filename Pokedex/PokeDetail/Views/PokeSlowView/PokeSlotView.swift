import UIKit

class PokeSlotView: UIView {
    let viewModel: PokeSlotViewModel
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Chip")
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Signika-Light", size: 16)
        return label
    }()
    
    init(viewModel: PokeSlotViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
                
        addSubview(container)
        container.anchor(to: self)
        
        container.addSubview(label)
        label.anchor(to: container, margin: 4)
        
        onUpdate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init with coder is not supported")
    }
    
    private func onUpdate() {
        label.text = viewModel.title
    }
}
