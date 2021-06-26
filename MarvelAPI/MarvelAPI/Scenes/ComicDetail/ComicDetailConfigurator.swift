import UIKit

final class ComicDetailConfigurator {
    func instantiateView(comic: MarvelComic) -> UIViewController {
        let dataStore = ComicDetailDataStore(comic: comic)
        let presenter = ComicDetailPresenter()
        let view = ComicDetailView()
        let interactor = ComicDetailInteractor(dataStore: dataStore, presenter: presenter)
        let viewController = ComicDetailViewController(interactor: interactor, customView: view)

        presenter.view = viewController

        return viewController
    }
}
