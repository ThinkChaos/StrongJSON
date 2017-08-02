import Foundation


/**
 * Deserializer type for `Dictionary`.
 *
 * - Note: The `Dictionary`'s `Key` type is `String` all that's all JSON allows.
 */
public class JSONDictionary<T: JSONDeserializer>: JSONDeserializer {

    /// Outputs a dictionary mapping `String`s to `T`'s output type.
    public typealias Deserialized = [String: T.Deserialized]

    /**
     * Deserializes `dictionary` and its contents.
     *
     * - Throws: Lets `T.deserialize`'s errors go through.
     */
    public static func deserialize(dictionary: NSDictionary) throws -> Deserialized {
        var res = Deserialized(minimumCapacity: dictionary.count)

        for (key, val) in dictionary {
            // If key were not a String, JSONSerialization.jsonObject(with:options:) would've thrown already
            // swiftlint:disable:next force_cast
            res[key as! String] = try T.deserialize(val)
        }

        return res
    }
}
