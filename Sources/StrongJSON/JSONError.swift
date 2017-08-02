import Foundation


/// The domain for this library's `NSError`s.
public let errorDomain = "thinkchaos.jsondeserialize"


/// A type representing JSON parsing and deserialization errors.
public enum JSONError: Error {

    /**
     * The JSON appears to be invalid.
     *
     * - `underlyingError`: the error thrown by `JSONSerialization.jsonObject(with:options:)`.
     */
    case invalidJSON(underlyingError: NSError)

    /**
     * The `String` could not be encoded in UTF-8.
     *
     * - `string`: the string that caused the error.
     */
    case invalidUTF8String(string: String)

    /**
     * The deserializer encountered an unexpected value.
     *
     * - `cause`: the reason the value is invalid.
     */
    case invalidValue(cause: String)

    /**
     * A value required by the deserializer was missing.
     *
     * - `name`: the name of the missing value.
     */
    case missingValue(name: String)

    /**
     * The deserializer encountered an unexpected type.
     *
     * - `type`: the type found.
     * - `whenDeserializing`: the type we were deserializing.
     */
    case unexpectedType(type: String, whenDeserializing: String)

    /**
     * Convert this `JSONError` into an `NSError`.
     *
     * - Note: The `NSError`'s code is one of `JSONErrorCode`.
     * - Note: The `NSError`'s `localizedDescription` will always be a human readable english.
     * - Note: For `invalidJSON`, the `userInfo` also has a value for `NSUnderlyingErrorKey`.
     *
     * - Returns: An `NSError` corresponding to `self`.
     */
    public func toNSError() -> NSError {
        var userInfo = [AnyHashable: Any]()

        userInfo[NSLocalizedDescriptionKey] = "\(self)"

        switch self {
        case .invalidJSON(let err):
            userInfo[NSLocalizedDescriptionKey] = "The JSON was invalid."
            userInfo[NSUnderlyingErrorKey] = err

        case .invalidUTF8String:
            userInfo[NSLocalizedDescriptionKey] = "The string you tried to parse couldn't be encoded in UTF-8."

        case .invalidValue(let cause):
            userInfo[NSLocalizedDescriptionKey] = cause

        case .missingValue(let name):
            userInfo[NSLocalizedDescriptionKey] = "The value for \"\(name)\" is missing."

        case .unexpectedType(let type, whenDeserializing: let expected):
            userInfo[NSLocalizedDescriptionKey] = "Expecting a value of type \(expected), got a: \(type)."
        }

        return NSError(
            domain: errorDomain,
            code: JSONErrorCode(error: self).rawValue,
            userInfo: userInfo
        )
    }
}
