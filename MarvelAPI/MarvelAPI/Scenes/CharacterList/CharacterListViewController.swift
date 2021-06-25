import UIKit

protocol CharacterListDisplayLogic: AnyObject {
    func showCharacterList(viewModel: CharacterList.FetchCharacterList.ViewModel.Success)
    func showError(viewModel: CharacterList.FetchCharacterList.ViewModel.Failure)
}

final class CharacterListViewController: UIViewController {
    private let customView: CharacterListViewProtocol & UIView
    private let interactor: CharacterListBusinessLogic
    private let router: CharacterListRoutingLogic

    private var marvelCharacters: [MarvelCharacter] = []
    private var isLoadingMore = false

    init(
        interactor: CharacterListBusinessLogic,
        router: CharacterListRoutingLogic,
        customView: CharacterListViewProtocol & UIView
    ) {
        self.interactor = interactor
        self.router = router
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
        self.customView.dataSourceDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = L10n.CharacterList.NavigationBar.title
        customView.showLoadingScreen()
        interactor.fetchCharacterList(request: .init())
    }

    func shouldLoadMore(indexPath: IndexPath) {
        if !isLoadingMore, indexPath.row == marvelCharacters.count - 1 {
            interactor.fetchCharacterList(request: .init())
            customView.addLoadingFooter()
        }
    }

    func stopLoading() {
        isLoadingMore = false
        customView.dismissLoadingScreen()
        customView.removeLoadingFooter()
    }
}

extension CharacterListViewController: CharacterListDisplayLogic {
    func showCharacterList(viewModel: CharacterList.FetchCharacterList.ViewModel.Success) {
        stopLoading()
        marvelCharacters.append(contentsOf: viewModel.marvelCharacters)
        customView.addRows(numberOfRows: viewModel.marvelCharacters.count)
    }

    func showError(viewModel: CharacterList.FetchCharacterList.ViewModel.Failure) {
        stopLoading()
        let alertController = UIAlertController(title: viewModel.title, message: viewModel.description, preferredStyle: .alert)
        let okAction = UIAlertAction(title: L10n.ErrorAlertController.okAction, style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension CharacterListViewController: UITableViewDelegate {
    
}

extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marvelCharacters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListTableViewCell.identifier, for: indexPath) as? CharacterListTableViewCell else {
            return UITableViewCell()
        }

        shouldLoadMore(indexPath: indexPath)
        cell.set(marvelCharacter: marvelCharacters[indexPath.row])

        return cell
    }
}
