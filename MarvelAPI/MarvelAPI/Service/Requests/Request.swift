import Foundation
import Alamofire

protocol Request {
    var path: String { get }
    var parameters: Parameters { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
}
