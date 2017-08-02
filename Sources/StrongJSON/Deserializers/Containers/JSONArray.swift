import Foundation


/// Deserializer type for `Array`.
public class JSONArray<T: JSONDeserializer>: JSONDeserializer {

    /// Outputs an array of `T`'s output type.
    public typealias Deserialized = [T.Deserialized]

    /**
     * Deserializes `array` and its contents.
     *
     * - Throws: Lets `T.deserialize`'s errors go through.
     */
    public static func deserialize(array: NSArray) throws -> Deserialized {
        return try array.map(T.deserialize)
    }
}
