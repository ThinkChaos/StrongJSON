import Foundation


/**
 * A protocol for types that deserialize themselves from JSON.
 *
 * Helps reduces boilerplate for types that deserialize themselves from a single source type.
 * Using this protocol you only have to:
 *
 *  - specify the `JSONRepresentation` type
 *  - implement `init(jsonData:)`
 *
 * For an example, see [UsageTests.swift](https://github.com/ThinkChaos/StrongJSON/blob/master/Tests/StrongJSONTests/UsageTests.swift).
 */
public protocol JSONRepresentable: JSONDeserializer {

    /**
     * The type that represents `Self`, as returned by `JSONSerialization.jsonObject(with:options:)`.
     *
     * Defaults to `NSDictionary` as this protocol is mostly used on classes.
     */
    associatedtype JSONRepresentation: JSONAnyParsedObject = NSDictionary

     /// Deserialises `jsonData` into an instance of `Self`.
    init(jsonData: JSONRepresentation) throws
}

public extension JSONRepresentable {

    /// A JSONRepresentable always deserializes itself.
    typealias Deserialized = Self

    /**
     * Tries casting the `JSONParsedObject` to `JSONRepresentation`, and calls `init(jsonData:)`.
     *
     * - Throws: `JSONError.unexpectedType` when `jsonObject` can't be converted.
     *            Also lets `init(jsonData:)`'s errors go through.
     */
    static func deserialize(jsonObject: JSONParsedObject) throws -> Self {
        guard let jsonData = jsonObject.inner as? JSONRepresentation else {
            throw JSONError.unexpectedType(type: jsonObject.typeName, whenDeserializing: "\(Self.self)")
        }

        return try Self.init(jsonData: jsonData)
    }
}
