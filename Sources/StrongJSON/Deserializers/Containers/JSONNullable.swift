import Foundation


/**
 * Deserializer type for `Optional<T>`, where `T: JSONDeserializer`.
 *
 * Use this deserializer when the JSON value is either `null`, or a valid `T.Deserialized`.
 *
 * - See: `JSONOptional`, for values that might not be present in the JSON.
 */
public class JSONNullable<T: JSONDeserializer>: JSONDeserializer {

    /// Outputs `nil` or `T`'s output type.
    public typealias Deserialized = T.Deserialized?

    /**
     * Returns `nil` when the JSON value is `null`, otherwise returns the result of `T.deserialize`.
     *
     * - Throws: Lets `T.deserialize` errors go through.
     */
    public static func deserialize(jsonObject: JSONParsedObject) throws -> Deserialized {
        switch jsonObject {
        case .null:
            return nil
        default:
            return try T.deserialize(jsonObject: jsonObject)
        }
    }
}
