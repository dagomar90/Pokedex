import Foundation

struct PokeListCoordinator {
    let presenter: Presenter
    
    func start() {
        presenter.present(viewController: PokeListViewController())
    }
}
