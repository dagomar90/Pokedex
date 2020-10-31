import Foundation

struct PokeDetailCoordinator {
    let preview: PokePreview
    let presenter: Presenter
    let network: NetworkContextProtocol
    
    func start() {
        let viewModel = PokeDetailViewModel(preview: preview, network: network)
        presenter.present(viewController: PokeDetailViewController(viewModel: viewModel))
    }
}
