import Foundation

extension Date {
    var timestamp: String {
        return String(Int(timeIntervalSince1970) * 1000)
    }
}
