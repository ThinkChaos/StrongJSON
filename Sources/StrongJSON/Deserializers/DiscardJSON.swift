import Foundation


/**
 * Deserializer type that discards values.
 *
 * Useful when you have a type that is generic over a `JSONDeserializer`,
 * but don't care about accessing the JSON's data.
 */
public class DiscardJSON: JSONDeserializer {

    /// This deserializer has no output.
    public typealias Deserialized = Void

    /// A no-op.
    public static func parseJSON(_: Data) -> Deserialized {}

    /// A no-op.
    public static func parseJSON(_: String) -> Deserialized {}

    /// A no-op.
    public static func deserialize(jsonObject: JSONParsedObject) -> Deserialized {}
}
