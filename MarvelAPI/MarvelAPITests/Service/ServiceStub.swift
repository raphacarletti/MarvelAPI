import Foundation
@testable import MarvelAPI

final class ServiceStub: ServiceRequest {
    private(set) var requestCodableCalled = false
    private(set) var requestCodableParameter: Request?
    var requestCodableReturnSuccess: MarvelCharacterResponse?
    func requestCodable<T>(_ request: Request, to: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        requestCodableCalled = true
        requestCodableParameter = request
        if let success = requestCodableReturnSuccess {
            completion(.success(success as! T))
        } else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        }
    }
}
