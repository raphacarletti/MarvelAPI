import Foundation

extension Mirror {
    public func firstChild<T>(of _: T.Type, in label: String? = nil) -> T? {
        children.lazy.compactMap {
            guard let value = $0.value as? T else { return nil }
            guard let label = label else { return value }
            return $0.label == label ? value : nil
        }.first
    }

    public func reflectFirstChild<T>(of type: T.Type, in label: String? = nil) -> Mirror? {
        guard let child = firstChild(of: T.self, in: label) else {
            return nil
        }
        return Mirror(reflecting: child)
    }
}
