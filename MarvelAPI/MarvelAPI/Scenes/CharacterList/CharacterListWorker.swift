import Foundation

protocol CharacterListWorkerProtocol: AnyObject {
    func fetchCharacterList(completion: @escaping (Result<[MarvelCharacter], Error>) -> Void)
}

final class CharacterListWorker: CharacterListWorkerProtocol {
    private let service: ServiceRequest
    private var offset = 0

    init(service: ServiceRequest = Service()) {
        self.service = service
    }

    func fetchCharacterList(completion: @escaping (Result<[MarvelCharacter], Error>) -> Void) {
        let request = MarvelRequest.characterList(offset)
        service.requestCodable(request, to: MarvelResponse.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.offset += ServiceConstants.responseLimit
                completion(.success(response.data.results))
            case .failure(let error):
                break
            }
        }
    }
}
