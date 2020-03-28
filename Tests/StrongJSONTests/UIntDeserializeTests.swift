import StrongJSON
import XCTest


class UIntDeserializeTests: XCTestCase {
    func testUInt() {
        XCTAssertEqual(try UInt.parse("\(UInt.min)"), UInt.min)
        XCTAssertEqual(try UInt.parse("\(UInt.max)"), UInt.max)
    }

    func testUInt8() {
        XCTAssertEqual(try UInt8.parse("\(UInt8.min)"), UInt8.min)
        XCTAssertEqual(try UInt8.parse("\(UInt8.max)"), UInt8.max)
    }

    func testUInt16() {
        XCTAssertEqual(try UInt16.parse("\(UInt16.min)"), UInt16.min)
        XCTAssertEqual(try UInt16.parse("\(UInt16.max)"), UInt16.max)
    }

    func testUInt32() {
        XCTAssertEqual(try UInt32.parse("\(UInt32.min)"), UInt32.min)
        XCTAssertEqual(try UInt32.parse("\(UInt32.max)"), UInt32.max)
    }

    func testUInt64() {
        XCTAssertEqual(try UInt64.parse("\(UInt64.min)"), UInt64.min)
        XCTAssertEqual(try UInt64.parse("\(UInt64.max)"), UInt64.max)
    }

    func testNegativeValue() {
        XCTAssertThrowsError(try UInt.parse("-1"))
        XCTAssertThrowsError(try UInt8.parse("-1"))
        XCTAssertThrowsError(try UInt16.parse("-1"))
        XCTAssertThrowsError(try UInt32.parse("-1"))
        XCTAssertThrowsError(try UInt64.parse("-1"))

        XCTAssertThrowsError(try UInt.parse("\(Int.min)"))
        XCTAssertThrowsError(try UInt8.parse("\(Int8.min)"))
        XCTAssertThrowsError(try UInt16.parse("\(Int16.min)"))
        XCTAssertThrowsError(try UInt32.parse("\(Int32.min)"))
        XCTAssertThrowsError(try UInt64.parse("\(Int64.min)"))
    }

    func testNonIntegralValue() {
        XCTAssertThrowsError(try UInt.parse("0.1"))
        XCTAssertThrowsError(try UInt8.parse("0.1"))
        XCTAssertThrowsError(try UInt16.parse("0.1"))
        XCTAssertThrowsError(try UInt32.parse("0.1"))
        XCTAssertThrowsError(try UInt64.parse("0.1"))
    }

    func testBool() {
        XCTAssertThrowsError(try UInt.parse("true"))
        XCTAssertThrowsError(try UInt8.parse("true"))
        XCTAssertThrowsError(try UInt16.parse("true"))
        XCTAssertThrowsError(try UInt32.parse("true"))
        XCTAssertThrowsError(try UInt64.parse("true"))

        XCTAssertThrowsError(try UInt.parse("false"))
        XCTAssertThrowsError(try UInt8.parse("false"))
        XCTAssertThrowsError(try UInt16.parse("false"))
        XCTAssertThrowsError(try UInt32.parse("false"))
        XCTAssertThrowsError(try UInt64.parse("false"))
    }

    func testOverflowingValue() {
#if arch(arm) || arch(i386)
        XCTAssertThrowsError(try UInt.parse("\(UInt32.max.toUIntMax() + 1)"))
#endif
        XCTAssertThrowsError(try UInt8.parse("\(UIntMax(UInt8.max) + 1)"))
        XCTAssertThrowsError(try UInt16.parse("\(UIntMax(UInt16.max) + 1)"))
        XCTAssertThrowsError(try UInt32.parse("\(UIntMax(UInt32.max) + 1)"))
    }
}
