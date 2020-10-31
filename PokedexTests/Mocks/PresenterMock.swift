import UIKit
@testable import Pokedex

class PresenterMock: Presenter {
    var presentCount: Int = 0
    var presentHandler: (UIViewController) -> Void = { _ in }
    
    func present(viewController: UIViewController) {
        presentCount += 1
        presentHandler(viewController)
    }
}
