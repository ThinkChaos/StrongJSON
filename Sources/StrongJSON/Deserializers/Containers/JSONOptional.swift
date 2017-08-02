import Foundation


/**
 * Deserializer type for `Optional<T>`, where `T: JSONDeserializer`.
 *
 * Use this deserializer when the JSON value is either missing, or a valid `T.Deserialized`.
 *
 * - See: `JSONNullable`, for values that might be `null`.
 */
public final class JSONOptional<T: JSONDeserializer>: JSONDeserializer {

    /// Outputs `nil` or `T`'s output type.
    public typealias Deserialized = T.Deserialized?

    /**
     * Deserialize `object` into `T`.
     *
     * This function is exactly equivalent to: `T.deserialize(object)`.
     *
     * - Throws: Lets `T.deserialize`'s errors go through.
     *
     * - Returns: The value of `T.deserialize(object)`.
     */
    public static func deserialize(jsonObject: JSONParsedObject) throws -> Deserialized {
        return try T.deserialize(jsonObject: jsonObject)
    }

    /**
     * Provides a default value of `nil` (ie. `.some(.none)`).
     *
     * - Throws: See `JSONDeserializer.deserialize(key:of:orDefault:)`.
     */
    public static func deserialize(key: String, of dictionary: NSDictionary) throws -> Deserialized {
        return try JSONOptional.deserialize(key: key, of: dictionary, orDefault: .some(.none))
    }

    /**
     * Provides a default value of `nil` (ie. `.some(.none)`).
     *
     * - Throws: See `JSONDeserializer.deserialize(keyAt:of:orDefault:)`.
     */
    public static func deserialize(keyAt path: [String], of dictionary: NSDictionary) throws -> Deserialized {
        return try JSONOptional.deserialize(keyAt: path, of: dictionary, orDefault: .some(.none))
    }
}
