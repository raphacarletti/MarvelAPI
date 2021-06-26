import Foundation

protocol ComicDetailBusinessLogic: AnyObject {
    func fetchComic(request: ComicDetail.FetchComic.Request)
}

final class ComicDetailInteractor: ComicDetailBusinessLogic {
    private var dataStore: ComicDetailDataStoreProtocol
    private var presenter: ComicDetailPresentationLogic

    init(
        dataStore: ComicDetailDataStoreProtocol,
        presenter: ComicDetailPresentationLogic
    ) {
        self.dataStore = dataStore
        self.presenter = presenter
    }

    func fetchComic(request: ComicDetail.FetchComic.Request) {
        presenter.presentComic(response: .init(comic: dataStore.comic))
    }
}
