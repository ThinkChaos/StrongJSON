import Foundation


/// Deserializer for `Float32` (aka. `Float`).
extension Float32: JSONRepresentable {

    /// `Float32` deserializes from `NSNumber`.
    public typealias JSONRepresentation = NSNumber

    /**
     * Gets the `Float32` from `NSNumber`.
     *
     * - Throws: `JSONError.unexpectedType` when the value can't be converted,
     *           or conversion would lead to a loss of information.
     */
    public init(jsonData number: JSONRepresentation) throws {
        self = try number.checkedCast(to: number.floatValue)
    }
}

/// Deserializer for `Float64` (aka. `Double`).
extension Float64: JSONRepresentable {

    /// `Float64` deserializes from `NSNumber`.
    public typealias JSONRepresentation = NSNumber

    /**
     * Gets the `Float64` from `NSNumber`.
     *
     * - Throws: `JSONError.unexpectedType` when the value can't be converted,
     *           or conversion would lead to a loss of information.
     */
    public init(jsonData number: JSONRepresentation) throws {
        self = try number.checkedCast(to: number.doubleValue)
    }
}
