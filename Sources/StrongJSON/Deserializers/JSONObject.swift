import Foundation


/// Deserializer to get the Foundation object as returned by `JSONSerialization.jsonObject(with:options:)`.
public final class JSONObject: JSONDeserializer {

    public typealias Deserialized = JSONAnyParsedObject

    /**
     * Returns the `object` wrapped by `jsonObject`.
     *
     * - Throws: Does **not** throw any errors.
     */
    public static func deserialize(jsonObject: JSONParsedObject) throws -> Deserialized {
        return jsonObject.inner
    }
}
