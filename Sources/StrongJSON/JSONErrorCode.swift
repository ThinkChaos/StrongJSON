import Foundation


/// The `NSError` codes for errors returned by `JSONError.toNSError()`.
public enum JSONErrorCode: Int {

    /// Error code for `JSONError.invalidJSON`.
    case invalidJSON

    /// Error code for `JSONError.invalidString`.
    case invalidString

    /// Error code for `JSONError.invalidValue`.
    case invalidValue

    /// Error code for `JSONError.missingValue`.
    case missingValue

    /// Error code for `JSONError.unexpectedType`.
    case unexpectedType

    internal init(error: JSONError) {
        switch error {
        case .invalidJSON:
            self = .invalidJSON
        case .invalidUTF8String:
            self = .invalidString
        case .invalidValue:
            self = .invalidValue
        case .missingValue:
            self = .missingValue
        case .unexpectedType:
            self = .unexpectedType
        }
    }
}
