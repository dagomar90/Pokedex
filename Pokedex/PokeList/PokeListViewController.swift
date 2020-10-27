import UIKit

class PokeListViewController: UIViewController {
    private lazy var tableView: PokeListTableView = {
        PokeListTableView.setup(delegate: self,
                                dataSource: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.anchor(to: view)
    }
}

extension UIView {
    func anchor(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topAnchor.constraint(equalTo: view.topAnchor),
                                     bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     leftAnchor.constraint(equalTo: view.leftAnchor),
                                     rightAnchor.constraint(equalTo: view.rightAnchor)])
    }
}

extension PokeListViewController: UITableViewDelegate {
    
}

extension PokeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PokeListTableViewCell.self)")
        return cell ?? UITableViewCell()
    }
}
