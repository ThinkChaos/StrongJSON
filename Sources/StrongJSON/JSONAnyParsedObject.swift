import Foundation


/**
 * Implemented by Foundation types returned by `JSONSerialization.jsonObject(with:options:)`:
 *
 *   - NSArray
 *   - NSDictionary
 *   - NSNull
 *   - NSNumber
 *   - NSString
 */
public protocol JSONAnyParsedObject {}

extension NSArray: JSONAnyParsedObject {}
extension NSDictionary: JSONAnyParsedObject {}
extension NSNull: JSONAnyParsedObject {}
extension NSNumber: JSONAnyParsedObject {}
extension NSString: JSONAnyParsedObject {}
