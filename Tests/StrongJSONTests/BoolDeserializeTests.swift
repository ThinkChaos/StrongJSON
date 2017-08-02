import StrongJSON
import XCTest


class BoolDeserializeTests: XCTestCase {
    func testTrue() {
        XCTAssert(try Bool.parse("true"))
    }

    func testFalse() {
        XCTAssertFalse(try Bool.parse("false"))
    }

    func testNumbers() {
        XCTAssertThrowsError(try Bool.parse("0"))
        XCTAssertThrowsError(try Bool.parse("1"))

        XCTAssertThrowsError(try Bool.parse("-1"))
        XCTAssertThrowsError(try Bool.parse(".1"))
    }
}
