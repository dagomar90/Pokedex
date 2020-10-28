import Foundation
import UIKit

struct PokeListCoordinator {
    let presenter: Presenter
    
    func start() {
        let navigationController = UINavigationController(rootViewController: PokeListViewController())
        navigationController.navigationBar.barTintColor = UIColor.white
        navigationController.navigationBar.isTranslucent = false
        navigationController.topViewController?.navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        presenter.present(viewController: navigationController)
    }
}
