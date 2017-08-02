import Foundation


/// Deserializer for `String`.
extension String: JSONRepresentable {

    /// `String` deserializes from `NSString`.
    public typealias JSONRepresentation = NSString

    /// Initializes this `String` with the `NSString`.
    public init(jsonData: JSONRepresentation) throws {
        self.init(jsonData)
    }
}
