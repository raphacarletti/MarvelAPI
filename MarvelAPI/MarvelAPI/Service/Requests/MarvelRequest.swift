import Foundation
import Alamofire

enum MarvelRequest: Request {
    case characterList(_ offset: Int)
    case comics(_ characterId: Int)

    var path: String {
        switch self {
        case .characterList:
            return "/v1/public/characters"
        case .comics(let characterId):
            return "/v1/public/characters/\(characterId)/comics"
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
        default:
            parameter["limit"] = ServiceConstants.maxResponseLimit
        }

        return parameter
    }

    var method: HTTPMethod {
        switch self {
        case .characterList, .comics:
            return .get
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .characterList, .comics:
            return URLEncoding.default
        }
    }

    
}
