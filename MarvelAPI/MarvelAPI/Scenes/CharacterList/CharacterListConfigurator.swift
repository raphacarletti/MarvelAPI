import UIKit

public final class CharacterListConfigurator {

    public init() {}

    public func instantiateView() -> UIViewController {
        let router = CharacterListRouter()
        let presenter = CharacterListPresenter()
        let interactor = CharacterListInteractor(presenter: presenter)
        let view = CharacterListView()
        let viewController = CharacterListViewController(interactor: interactor, router: router, customView: view)

        router.viewController = viewController
        presenter.view = viewController

        return viewController
    }
}
