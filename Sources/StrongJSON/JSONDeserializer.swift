import Foundation


/**
 * A protocol for types that can deserialize JSON.
 *
 * All methods have default implementations. See `JSONDeserializer`'s extensions for details.
 */
public protocol JSONDeserializer {

    /// The output type for this deserializer.
    associatedtype Deserialized

    /**
     * Deserializes `jsonObject` into a value of type `Deserialized`.
     *
     * This method is provided so overriding all deserialization doesn't
     * require overriding all the different `deserialize` methods.
     */
    static func deserialize(jsonObject: JSONParsedObject) throws -> Deserialized

    /// Deserializes `array` into a value of type `Deserialized`.
    static func deserialize(array: NSArray) throws -> Deserialized

    /// Deserializes `dictionary` into a value of type `Deserialized`.
    static func deserialize(dictionary: NSDictionary) throws -> Deserialized

    /// Deserializes `null` into a value of type `Deserialized`.
    static func deserialize(null: NSNull) throws -> Deserialized

    /// Deserializes `number` into a value of type `Deserialized`.
    static func deserialize(number: NSNumber) throws -> Deserialized

    /// Deserializes `string` into a value of type `Deserialized`.
    static func deserialize(string: NSString) throws -> Deserialized
}
