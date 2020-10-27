import UIKit

extension UIViewController: Presenter {
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
}
