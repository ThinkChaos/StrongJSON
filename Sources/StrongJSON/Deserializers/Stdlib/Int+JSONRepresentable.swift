import Foundation


/// Deserializer for `Int`.
extension Int: JSONRepresentable {

    /// `Int` deserializes from `NSNumber`.
    public typealias JSONRepresentation = NSNumber

    /**
     * Gets the `Int` from `NSNumber`.
     *
     * - Throws: `JSONError.unexpectedType` when the value can't be converted,
     *           or conversion would lead to a loss of information.
     */
    public init(jsonData number: JSONRepresentation) throws {
        self = try number.checkedCast(to: number.intValue, typeMinValue: Int.min, typeMaxValue: Int.max)
    }
}

/// Deserializer for `Int8`.
extension Int8: JSONRepresentable {

    /// `Int8` deserializes from `NSNumber`.
    public typealias JSONRepresentation = NSNumber

    /**
     * Gets the `Int8` from `NSNumber`.
     *
     * - Throws: `JSONError.unexpectedType` when the value can't be converted,
     *           or conversion would lead to a loss of information.
     */
    public init(jsonData number: JSONRepresentation) throws {
        self = try number.checkedCast(to: number.int8Value, typeMinValue: Int8.min, typeMaxValue: Int8.max)
    }
}

/// Deserializer for `Int16`.
extension Int16: JSONRepresentable {

    /// `Int16` deserializes from `NSNumber`.
    public typealias JSONRepresentation = NSNumber

    /**
     * Gets the `Int16` from `NSNumber`.
     *
     * - Throws: `JSONError.unexpectedType` when the value can't be converted,
     *           or conversion would lead to a loss of information.
     */
    public init(jsonData number: JSONRepresentation) throws {
        self = try number.checkedCast(to: number.int16Value, typeMinValue: Int16.min, typeMaxValue: Int16.max)
    }
}

/// Deserializer for `Int32`.
extension Int32: JSONRepresentable {

    /// `Int32` deserializes from `NSNumber`.
    public typealias JSONRepresentation = NSNumber

    /**
     * Gets the `Int32` from `NSNumber`.
     *
     * - Throws: `JSONError.unexpectedType` when the value can't be converted,
     *           or conversion would lead to a loss of information.
     */
    public init(jsonData number: JSONRepresentation) throws {
        self = try number.checkedCast(to: number.int32Value, typeMinValue: Int32.min, typeMaxValue: Int32.max)
    }
}

/// Deserializer for `Int64`.
extension Int64: JSONRepresentable {

    /// `Int64` deserializes from `NSNumber`.
    public typealias JSONRepresentation = NSNumber

    /**
     * Gets the `Int64` from `NSNumber`.
     *
     * - Throws: `JSONError.unexpectedType` when the value can't be converted,
     *           or conversion would lead to a loss of information.
     */
    public init(jsonData number: JSONRepresentation) throws {
        self = try number.checkedCast(to: number.int64Value, typeMinValue: Int64.min, typeMaxValue: Int64.max)
    }
}
