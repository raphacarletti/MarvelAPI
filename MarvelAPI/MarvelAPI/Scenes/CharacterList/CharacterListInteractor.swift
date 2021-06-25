import Foundation

protocol CharacterListBusinessLogic: AnyObject {
    func fetchCharacterList(request: CharacterList.FetchCharacterList.Request)
}

final class CharacterListInteractor: CharacterListBusinessLogic {
    private let presenter: CharacterListPresentationLogic
    private let worker: CharacterListWorkerProtocol

    init(
        presenter: CharacterListPresentationLogic,
        worker: CharacterListWorkerProtocol = CharacterListWorker()
    ) {
        self.presenter = presenter
        self.worker = worker
    }

    func fetchCharacterList(request: CharacterList.FetchCharacterList.Request) {
        worker.fetchCharacterList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let characters):
                self.presenter.presentCharacterListSuccess(response: .init(marvelCharacters: characters))
            case .failure(_):
                self.presenter.presentCharacterListError(response: .init())
            }
        }
    }
}
