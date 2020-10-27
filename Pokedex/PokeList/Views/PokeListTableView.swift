import UIKit

class PokeListTableView: UITableView {
    static func setup(delegate: UITableViewDelegate? = nil,
                      dataSource: UITableViewDataSource? = nil) -> PokeListTableView {
        let tableView = PokeListTableView()
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.register(PokeListTableViewCell.self, forCellReuseIdentifier: "\(PokeListTableViewCell.self)")
        tableView.separatorStyle = .none
        return tableView
    }
}
