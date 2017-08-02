import Foundation

/**
 * An enum to wrap objects returned by `JSONSerialization.jsonObject(with:options:)`.
 *
 * Implements `JSONDeserializer` with `Deserialized = Self`.
 */
public enum JSONParsedObject: JSONDeserializer {

    /// Wraps an array.
    case array(NSArray)

    /// Wraps a dictionary.
    case dictionary(NSDictionary)

    /// Wraps a null.
    case null(NSNull)

    /// Wraps a number.
    case number(NSNumber)

    /// Wraps a string.
    case string(NSString)

    internal init?(from object: Any) {
        switch object {
        case let object as NSArray:
            self = .array(object)

        case let object as NSDictionary:
            self = .dictionary(object)

        case let object as NSNull:
            self = .null(object)

        case let object as NSNumber:
            self = .number(object)

        case let object as NSString:
            self = .string(object)

        default:
            return nil
        }
    }

    /// Access the wrapped object.
    public var inner: JSONAnyParsedObject {
        switch self {
        case let .array(inner):
            return inner

        case let .dictionary(inner):
            return inner

        case let .null(inner):
            return inner

        case let .number(inner):
            return inner

        case let .string(inner):
            return inner
        }
    }

    internal var typeName: String {
        switch self {
        case .array:
            return "NSArray"

        case .dictionary:
            return "NSDictionary"

        case .null:
            return "NSNull"

        case .number:
            return "NSNumber"

        case .string:
            return "NSString"
        }
    }

    // MARK: JSONDeserializer

    /// Output type is itself.
    public typealias Deserialized = JSONParsedObject

    /**
     * Returns `jsonObject`.
     *
     * - Throws: does **not** throw.
     */
    public static func deserialize(jsonObject: JSONParsedObject) throws -> Deserialized {
        return jsonObject
    }
}
