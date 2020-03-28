import Foundation


/// Extends JSONDeserializer to add convenient methods.
public extension JSONDeserializer {

    /**
     * Parse `data` using `JSONSerialization.jsonObject(with:options:)` and then calls
     * `deserialize(_:)` on the resulting object.
     *
     * `JSONSerialization.jsonObject(with:options:)` is called with the `allowFragments` option.
     * This should never be a problem thanks to the type checking that occurs, and
     * should you need it, you have it.
     *
     * - Throws: `JSONError.invalidJSON` when `JSONSerialization.jsonObject(with:options:)` fails.
     *           Lets `deserialize(_:)`'s errors go through.
     */
    static func parseJSON(_ data: Data) throws -> Deserialized {
        var object: Any

        do {
            object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        } catch let error as NSError {
            throw JSONError.invalidJSON(underlyingError: error)
        }

        return try Self.deserialize(object)
    }

    /**
     * Encodes the string as UTF-8 and calls `parseJSON` with that data.
     *
     * - Throws: `JSONError.invalidJSON` when `JSONSerialization.jsonObject(with:options:)` fails.
     *           Lets `parseJSON(_:)`'s errors go through.
     */
    static func parseJSON(_ string: String) throws -> Deserialized {
        guard let data = string.data(using: String.Encoding.utf8) else {
            throw JSONError.invalidUTF8String(string: string)
        }

        return try Self.parseJSON(data)
    }

    /**
     * Checks `object` is a type returned by `JSONSerialization.jsonObject(with:options:)`,
     * and calls `deserialize(jsonObject:)`.
     *
     * The object casted and wrapped in `JSONParsedObject`, this prevents from polluting
     * the interface with `Any`.
     *
     * If you're thinking about replacing this method, you should replace
     * `deserialize(jsonObject:)` instead:
     *
     *  - as with this method, all deserialization goes through it
     *  - you keep this method's sanity checks
     *  - you get extra information about the object (if you want the raw object, use `JSONParsedObject.inner`)
     */
    static func deserialize(_ object: Any) throws -> Deserialized {
        assert(!(object is Data),
               "You called `\(Self.self).deserialize()` with a Data instance. " +
               "Did you mean to call `\(Self.self).parseJSON`?"
        )

        assert(!(object is JSONParsedObject),
               "You called `\(Self.self).deserialize()` with a `JSONParsedObject` instance. " +
               "Did you mean to call `\(Self.self).deserialize(jsonObject:)`?"
        )

        guard let jsonObject = JSONParsedObject(from: object) else {
            // We should never get here: JSONSerialization.jsonObject(with:options:) only returns the types we checked

            // If in debug, make sure the programmer knows about this
            assertionFailure(
                "Cannot deserialize value of type `\(type(of: object))`: it is not a type returned by " +
                "`JSONSerialization.jsonObject(with:options:)`"
            )

            throw JSONError.unexpectedType(type: "\(type(of: object))", whenDeserializing: "\(Deserialized.self)")
        }

        return try Self.deserialize(jsonObject: jsonObject)
    }

    /**
     * Convenience function to deserialize a key from a dictionary.
     *
     * Using this function has the advantage of producing a nicer error when the key is missing.
     *
     * - Throws: `JSONError.missingValue` if the requested key was not found and no default was provided.
     *            Also lets `T.deserialize`'s errors go through.
     */
    static func deserialize(key: String,
                            of dictionary: NSDictionary,
                            orDefault def: Deserialized? = nil) throws -> Deserialized {
        guard let val = dictionary[key] else {
            guard let def = def else {
                throw JSONError.missingValue(name: key)
            }

            return def
        }

        return try Self.deserialize(val)
    }

    /**
     * Convenience function to deserialize a key from a nested dictionary.
     *
     * Using this function has the advantage of producing a nicer error when the key is missing.
     *
     * - Throws: `JSONError.missingValue` if the requested key was not found and no default was provided.
     *            Also lets `T.deserialize`'s errors go through.
     */
    static func deserialize(keyAt path: [String],
                            of dictionary: NSDictionary,
                            orDefault def: Deserialized? = nil) throws -> Deserialized {
        guard let last = path.last else {
            fatalError("Called \(Self.self).deserialize(keyAt:of:orDefault:) with an empty key path.")
        }

        var dictionary = dictionary

        var currPath = ""

        for key in path.makeIterator().dropLast() {
            currPath += key

            guard let nested = dictionary[key] else {
                guard let def = def else {
                    throw JSONError.missingValue(name: currPath)
                }

                return def
            }

            let jsonObject = try JSONParsedObject.deserialize(nested)

            guard case let .dictionary(next) = jsonObject else {
                throw JSONError.unexpectedType(type: jsonObject.typeName, whenDeserializing: "keyAt '\(currPath)' as NSDictionary")
            }

            currPath += "."
            dictionary = next
        }

        return try Self.deserialize(key: last, of: dictionary, orDefault: def)
    }
}
