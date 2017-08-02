import Foundation


/**
 * Deserializer for `URL`.
 */
extension URL: JSONRepresentable {

    /// `URL` deserializes from `NSString`.
    public typealias JSONRepresentation = NSString

    /**
     * Deserializes `string` into a URL.
     *
     * - Throws: `JSONError.invalidValue` when the URL is invalid.
     */
    public init(jsonData string: JSONRepresentation) throws {
        guard let url = URL(string: string as String) else {
            throw JSONError.invalidValue(cause: "Could not parse the URL: \(string)")
        }

        self = url
    }
}
