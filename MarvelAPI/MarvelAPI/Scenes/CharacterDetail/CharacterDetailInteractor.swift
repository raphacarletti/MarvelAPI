import Foundation

protocol CharacterDetailBusinessLogic: AnyObject {
    func fetchMarvelCharacter(request: CharacterDetail.FetchMarvelCharacter.Request)
    func fetchMostExpensiveMagazine(request: CharacterDetail.FetchMostExpensiveMaganize.Request)
}

final class CharacterDetailInteractor: CharacterDetailBusinessLogic {
    private var dataStore: CharacterDetailDataStoreProtocol
    private var presenter: CharacterDetailPresentationLogic
    private var worker: CharacterDetailWorkerProtocol

    init(
        dataStore: CharacterDetailDataStoreProtocol,
        presenter: CharacterDetailPresentationLogic,
        worker: CharacterDetailWorkerProtocol = CharacterDetailWorker()
    ) {
        self.dataStore = dataStore
        self.presenter = presenter
        self.worker = worker
    }

    func fetchMarvelCharacter(request: CharacterDetail.FetchMarvelCharacter.Request) {
        presenter.presentMarvelCharacter(response: .init(marvelCharacter: dataStore.marvelCharacter))
    }

    func fetchMostExpensiveMagazine(request: CharacterDetail.FetchMostExpensiveMaganize.Request) {
        worker.fetchMostExpensiveMagazine(characterId: dataStore.marvelCharacter.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let comic):
                self.presenter.presentMostExpensiveComicSuccess(response: .init(marvelComic: comic))
            case .failure(let error):
                self.presenter.presentMostExpensiveComicFailure(response: .init(error: error))
            }
        }
    }
}
