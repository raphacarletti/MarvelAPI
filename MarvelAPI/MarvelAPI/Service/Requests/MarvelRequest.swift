import Foundation
import Alamofire

enum MarvelRequest: Request {
    case characterList(_ offset: Int)
    var path: String {
        switch self {
        case .characterList:
            return "/v1/public/characters"
        }
    }

    var parameters: Parameters {
        var parameter: Parameters = [:]

        let timestamp = Date().timestamp
        parameter["ts"] = timestamp
        parameter["apikey"] = ServiceConstants.publicKey
        parameter["hash"] = (timestamp + ServiceConstants.privateKey + ServiceConstants.publicKey).md5

        switch self {
        case let .characterList(offset):
            parameter["orderBy"] = "name"
            parameter["limit"] = ServiceConstants.responseLimit
            parameter["offset"] = offset
        }

        return parameter
    }

    var method: HTTPMethod {
        switch self {
        case .characterList:
            return .get
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .characterList:
            return URLEncoding.default
        }
    }

    
}
