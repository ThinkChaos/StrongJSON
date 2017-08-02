import Foundation


/**
 * Deserializer for `null` values.
 *
 * Use this when you expect a value to be `null`, if it is not
 * a `JSONError.unexpectedType` will be thrown.
 */
public final class JSONNull<T>: JSONDeserializer {

    /// Output is `nil`.
    public typealias Deserialized = T?

    /**
     * Returns `nil`.
     *
     * - Throws: Does **not** throw any errors.
     */
    public static func deserialize(null: NSNull) throws -> Deserialized {
        return nil
    }
}
