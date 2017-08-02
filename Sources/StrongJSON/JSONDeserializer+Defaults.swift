import Foundation


/// Extends JSONDeserializer to add default implementations for all methods.
public extension JSONDeserializer {

    /**
     * Calls the `deserialized` method corresponding to `jsonObject`'s variant.
     *
     * Override this method if your deserializer doesn't depend on the `jsonObject`'s type.
     * Otherwise, you probably want to override the specialized `deserialize` method(s).
     *
     * For an example of the first, see `JSONObject`.
     */
    static func deserialize(jsonObject: JSONParsedObject) throws -> Deserialized {
        switch jsonObject {
        case let .array(object):
            return try Self.deserialize(array: object)

        case let .dictionary(object):
            return try Self.deserialize(dictionary: object)

        case let .null(object):
            return try Self.deserialize(null: object)

        case let .number(object):
            return try Self.deserialize(number: object)

        case let .string(object):
            return try Self.deserialize(string: object)
        }
    }

    /// - Throws: `JSONError.unexpectedType`.
    static func deserialize(array: NSArray) throws -> Deserialized {
        throw JSONError.unexpectedType(type: "Array", whenDeserializing: "\(Deserialized.self)")
    }

    /// - Throws: `JSONError.unexpectedType`.
    static func deserialize(dictionary: NSDictionary) throws -> Deserialized {
        throw JSONError.unexpectedType(type: "Dictionary", whenDeserializing: "\(Deserialized.self)")
    }

    /// - Throws: `JSONError.unexpectedType`.
    static func deserialize(null: NSNull) throws -> Deserialized {
        throw JSONError.unexpectedType(type: "null", whenDeserializing: "\(Deserialized.self)")
    }

    /// - Throws: `JSONError.unexpectedType`.
    static func deserialize(number: NSNumber) throws -> Deserialized {
        throw JSONError.unexpectedType(type: number.guessTypeName(), whenDeserializing: "\(Deserialized.self)")
    }

    /// - Throws: `JSONError.unexpectedType`.
    static func deserialize(string: NSString) throws -> Deserialized {
        throw JSONError.unexpectedType(type: "String", whenDeserializing: "\(Deserialized.self)")
    }
}
