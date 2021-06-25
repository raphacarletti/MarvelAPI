import Cartography
import UIKit

protocol CharacterListViewProtocol: AnyObject {
    var dataSourceDelegate: (UITableViewDelegate & UITableViewDataSource)? { get set }

    func addRows(numberOfRows: Int)
    func addLoadingFooter()
    func removeLoadingFooter()
    func showLoadingScreen()
    func dismissLoadingScreen()
}

final class CharacterListView: UIView, CharacterListViewProtocol {
    private var loadingView = LoadingView()
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CharacterListTableViewCell.self, forCellReuseIdentifier: CharacterListTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 84
        return tableView
    }()

    var dataSourceDelegate: (UITableViewDelegate & UITableViewDataSource)? {
        didSet {
            tableView.delegate = dataSourceDelegate
            tableView.dataSource = dataSourceDelegate
            tableView.reloadData()
        }
    }

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    private func setup() {
        addSubview(tableView)
        constrain(self, tableView) { superView, tableView in
            tableView.edges == superView.edges
        }
    }

    func addRows(numberOfRows: Int) {
        let actualNumberOfRows = tableView.numberOfRows(inSection: 0)
        var indexPaths: [IndexPath] = []
        for i in 0..<numberOfRows {
            indexPaths.append(IndexPath(row: actualNumberOfRows + i, section: 0))
        }
        tableView.insertRows(at: indexPaths, with: .automatic)
    }

    func addLoadingFooter() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.frame = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 70)
        spinner.startAnimating()
        tableView.tableFooterView = spinner
    }

    func removeLoadingFooter() {
        tableView.tableFooterView = nil
    }

    func showLoadingScreen() {
        addSubview(loadingView)
        constrain(self, loadingView) { superView, loadingView in
            loadingView.edges == superView.edges
        }
    }

    func dismissLoadingScreen() {
        loadingView.removeFromSuperview()
    }
}
