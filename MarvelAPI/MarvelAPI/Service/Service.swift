import Foundation
import Alamofire

protocol ServiceRequest {
    func requestCodable<T: Decodable>(_ request: Request, to: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

final class Service: ServiceRequest {
    func requestCodable<T: Decodable>(_ request: Request, to: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(ServiceConstants.baseUrl + request.path, method: request.method, parameters: request.parameters, encoding: request.encoding).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let decodable): 
                completion(.success(decodable))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
