import Foundation


/// Deserializer for `Bool`.
extension Bool: JSONRepresentable {

    /// `Bool` deserializes from `NSNumber`.
    public typealias JSONRepresentation = NSNumber

    /**
     * Gets the `Bool` from `NSNumber`.
     *
     * - Throws: `JSONError.unexpectedType` when the original value was not `true` or `false`.
     */
    public init(jsonData: JSONRepresentation) throws {
        self = try jsonData.checkedCast()
    }
}
