import Foundation
import StrongJSON


extension JSONDeserializer {
    /**
     * A shorthand to make tests lighter.
     */
    static func parse(_ string: String) throws -> Deserialized {
        return try Self.parseJSON(string)
    }
}
