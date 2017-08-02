import StrongJSON
import XCTest


class NullDeserializeTests: XCTestCase {
    func testNull() {
        XCTAssertNil(try JSONNull.parse("null"))
    }

    func testNotNull() {
        XCTAssertThrowsError(try JSONNull<Void>.parse("0"))
        XCTAssertThrowsError(try JSONNull<Void>.parse("\"abc\""))
    }
}
