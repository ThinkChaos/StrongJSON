import StrongJSON
import XCTest

enum BinaryDigit: Int, JSONRawRepresentable {
    case zero
    case one
}

class RawRepresentableTest: XCTestCase {
    func testValidValue() {
        XCTAssertEqual(try BinaryDigit.parse("0"), .zero)
        XCTAssertEqual(try BinaryDigit.parse("1"), .one)
    }

    func testBadValue() {
        XCTAssertThrowsError(try BinaryDigit.parse("2"))
    }

    func testBadType() {
        XCTAssertThrowsError(try BinaryDigit.parse("\"Ayy\""))
    }
}
