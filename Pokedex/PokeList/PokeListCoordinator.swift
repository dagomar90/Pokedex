import Foundation
import UIKit

protocol PokeListCoordinatorProtocol {
    func start()
    func showDetail(preview: PokePreview,
                    presenter: Presenter,
                    network: NetworkContextProtocol)
}

struct PokeListCoordinator: PokeListCoordinatorProtocol {
    let presenter: Presenter
    let network: NetworkContextProtocol
    
    func start() {
        let viewModel = PokeListViewModel(network: network, coordinator: self)
        let navigationController = UINavigationController(rootViewController: PokeListViewController( viewModel: viewModel))
        navigationController.navigationBar.barTintColor = UIColor.white
        navigationController.navigationBar.tintColor = UIColor.black
        navigationController.navigationBar.isTranslucent = false
        navigationController.topViewController?.navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        presenter.present(viewController: navigationController)
    }
    
    func showDetail(preview: PokePreview,
                    presenter: Presenter,
                    network: NetworkContextProtocol) {
        let coordinator = PokeDetailCoordinator(preview: preview, presenter: presenter, network: network)
        coordinator.start()
    }
}
