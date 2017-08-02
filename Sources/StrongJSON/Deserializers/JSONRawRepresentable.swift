import Foundation


/**
 * Protocol to auto-implement deserialization for `RawRepresentable` types.
 *
 * **Example:**  
 * The following enum automatically implements `JSONDeserializer`.
 *
 * ```swift
 * enum Lorem: String, JSONRawRepresentable {
 *     case ipsum
 *     case dolor
 *     case sitAmet
 * }
 * ```
 */
public protocol JSONRawRepresentable: JSONDeserializer, RawRepresentable {}

public extension JSONRawRepresentable {

    // Can't use JSONDeserializer: RawValue does not implement JSONAnyParsedObject
    typealias Deserialized = Self

    /**
     * Casts the `jsonObject` to `RawValue` and calls `init(rawValue:)`.
     *
     * - Throws:
     *     - `JSONError.unexpectedType` if `jsonObject` can't be casted to `RawValue`.
     *     - `JSONError.invalidValue` if `init(rawValue:)` returns `nil`.
     */
    static func deserialize(jsonObject: JSONParsedObject) throws -> Self {
        guard let rawValue = jsonObject.inner as? RawValue else {
            throw JSONError.unexpectedType(type: "\(jsonObject.typeName)", whenDeserializing: "\(Self.self)")
        }

        guard let result = Self.init(rawValue: rawValue) else {
            throw JSONError.invalidValue(cause: "Unknown value of type \(Self.self): \(rawValue)")
        }

        return result
    }
}
