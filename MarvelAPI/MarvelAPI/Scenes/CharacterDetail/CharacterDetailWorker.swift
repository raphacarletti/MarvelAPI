import Foundation

protocol CharacterDetailWorkerProtocol: AnyObject {
    func fetchMostExpensiveMagazine(characterId: Int, completion: @escaping (Result<MarvelComic, ComicError>) -> Void)
}

enum ComicError: String, Error {
    case network
    case notFound
}

final class CharacterDetailWorker: CharacterDetailWorkerProtocol {
    private let service: ServiceRequest

    init(service: ServiceRequest = Service()) {
        self.service = service
    }

    func fetchMostExpensiveMagazine(characterId: Int, completion: @escaping (Result<MarvelComic, ComicError>) -> Void) {
        let request = MarvelRequest.comics(characterId)
        service.requestCodable(request, to: MarvelComicResponse.self) { result in
            switch result {
            case .success(let comic):
                let results = comic.data.results
                guard !results.isEmpty else {
                    completion(.failure(.notFound))
                    return
                }

                guard let comic = results.sorted(by: { (comic1, comic2) -> Bool in
                    guard
                        let price1 = comic1.prices.first?.price,
                        let price2 = comic2.prices.first?.price
                    else { return false }
                    
                    return price1 > price2
                }).first else  {
                    completion(.failure(.notFound))
                    return
                }

                completion(.success(comic))
            case .failure:
                completion(.failure(.network))
            }
        }
    }
}
