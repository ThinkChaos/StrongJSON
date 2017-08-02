import Foundation


/**
 * Deserializer for `UInt`.
 */
extension UInt: JSONRepresentable {

    /// `UInt` deserializes from `NSNumber`.
    public typealias JSONRepresentation = NSNumber

    /**
     * Gets the `UInt` from the `NSNumber`.
     *
     * - Throws: `JSONError.unexpectedType` when the value can't be converted,
     *           or conversion would lead to a loss of information.
     */
    public init(jsonData number: JSONRepresentation) throws {
        self = try number.checkedCast(to: number.uintValue, typeMaxValue: UInt.max)
    }
}

/**
 * Deserializer for `UInt8`.
 */
extension UInt8: JSONRepresentable {

    /// `UInt8` deserializes from `NSNumber`.
    public typealias JSONRepresentation = NSNumber

    /**
     * Gets the `UInt8` from the `NSNumber`.
     *
     * - Throws: `JSONError.unexpectedType` when the value can't be converted,
     *           or conversion would lead to a loss of information.
     */
    public init(jsonData number: JSONRepresentation) throws {
        self = try number.checkedCast(to: number.uint8Value, typeMaxValue: UInt8.max)
    }
}

/**
 * Deserializer for `UInt16`.
 */
extension UInt16: JSONRepresentable {

    /// `UInt16` deserializes from `NSNumber`.
    public typealias JSONRepresentation = NSNumber

    /**
     * Gets the `UInt16` from the `NSNumber`.
     *
     * - Throws: `JSONError.unexpectedType` when the value can't be converted,
     *           or conversion would lead to a loss of information.
     */
    public init(jsonData number: JSONRepresentation) throws {
        self = try number.checkedCast(to: number.uint16Value, typeMaxValue: UInt16.max)
    }
}

/**
 * Deserializer for `UInt32`.
 */
extension UInt32: JSONRepresentable {

    /// `UInt32` deserializes from `NSNumber`.
    public typealias JSONRepresentation = NSNumber

    /**
     * Gets the `UInt32` from the `NSNumber`.
     *
     * - Throws: `JSONError.unexpectedType` when the value can't be converted,
     *           or conversion would lead to a loss of information.
     */
    public init(jsonData number: JSONRepresentation) throws {
        self = try number.checkedCast(to: number.uint32Value, typeMaxValue: UInt32.max)
    }
}

/**
 * Deserializer for `UInt64`.
 */
extension UInt64: JSONRepresentable {

    /// `UInt64` deserializes from `NSNumber`.
    public typealias JSONRepresentation = NSNumber

    /**
     * Gets the `UInt64` from the `NSNumber`.
     *
     * - Throws: `JSONError.unexpectedType` when the value can't be converted,
     *           or conversion would lead to a loss of information.
     */
    public init(jsonData number: JSONRepresentation) throws {
        self = try number.checkedCast(to: number.uint64Value, typeMaxValue: UInt64.max)
    }
}
