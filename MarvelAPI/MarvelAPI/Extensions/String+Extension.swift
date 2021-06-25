import Foundation
import CryptoKit

extension String {
    var md5: String {
        guard let data = self.data(using: .utf8) else { return "" }
        let computed = Insecure.MD5.hash(data: data)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}
