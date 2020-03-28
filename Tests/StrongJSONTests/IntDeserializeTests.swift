import StrongJSON
import XCTest


class IntDeserializeTests: XCTestCase {
    func testInt() {
        XCTAssertEqual(try Int.parse("0"), 0)
        XCTAssertEqual(try Int.parse("-1"), -1)
        XCTAssertEqual(try Int.parse("\(Int.min)"), Int.min)
        XCTAssertEqual(try Int.parse("\(Int.max)"), Int.max)
    }

    func testInt8() {
        XCTAssertEqual(try Int8.parse("0"), 0)
        XCTAssertEqual(try Int8.parse("-1"), -1)
        XCTAssertEqual(try Int8.parse("\(Int8.min)"), Int8.min)
        XCTAssertEqual(try Int8.parse("\(Int8.max)"), Int8.max)
    }

    func testInt16() {
        XCTAssertEqual(try Int16.parse("0"), 0)
        XCTAssertEqual(try Int16.parse("-1"), -1)
        XCTAssertEqual(try Int16.parse("\(Int16.min)"), Int16.min)
        XCTAssertEqual(try Int16.parse("\(Int16.max)"), Int16.max)
    }

    func testInt32() {
        XCTAssertEqual(try Int32.parse("0"), 0)
        XCTAssertEqual(try Int32.parse("-1"), -1)
        XCTAssertEqual(try Int32.parse("\(Int32.min)"), Int32.min)
        XCTAssertEqual(try Int32.parse("\(Int32.max)"), Int32.max)
    }

    func testInt64() {
        XCTAssertEqual(try Int64.parse("0"), 0)
        XCTAssertEqual(try Int64.parse("-1"), -1)
        XCTAssertEqual(try Int64.parse("\(Int64.min)"), Int64.min)
        XCTAssertEqual(try Int64.parse("\(Int64.max)"), Int64.max)
    }

    func testNonIntegralValue() {
        XCTAssertThrowsError(try Int.parse("0.1"))
        XCTAssertThrowsError(try Int8.parse("0.1"))
        XCTAssertThrowsError(try Int16.parse("0.1"))
        XCTAssertThrowsError(try Int32.parse("0.1"))
        XCTAssertThrowsError(try Int64.parse("0.1"))
    }

    func testBool() {
        XCTAssertThrowsError(try Int.parse("true"))
        XCTAssertThrowsError(try Int8.parse("true"))
        XCTAssertThrowsError(try Int16.parse("true"))
        XCTAssertThrowsError(try Int32.parse("true"))
        XCTAssertThrowsError(try Int64.parse("true"))

        XCTAssertThrowsError(try Int.parse("false"))
        XCTAssertThrowsError(try Int8.parse("false"))
        XCTAssertThrowsError(try Int16.parse("false"))
        XCTAssertThrowsError(try Int32.parse("false"))
        XCTAssertThrowsError(try Int64.parse("false"))
    }

    func testGreaterThanMaxValue() {
#if arch(arm) || arch(i386)
        XCTAssertThrowsError(try Int.parse("\(UInt.max.toIntMax() + 1)"))
#endif
        XCTAssertThrowsError(try Int8.parse("\(IntMax(Int8.max) + 1)"))
        XCTAssertThrowsError(try Int16.parse("\(IntMax(Int16.max) + 1)"))
        XCTAssertThrowsError(try Int32.parse("\(IntMax(Int32.max) + 1)"))
    }

    func testSmallerThanMinValue() {
#if arch(arm) || arch(i386)
        XCTAssertThrowsError(try Int.parse("\(Int.min.toIntMax() - 1)"))
#endif
        XCTAssertThrowsError(try Int8.parse("\(IntMax(Int8.min) - 1)"))
        XCTAssertThrowsError(try Int16.parse("\(IntMax(Int16.min) - 1)"))
        XCTAssertThrowsError(try Int32.parse("\(IntMax(Int32.min) - 1)"))
    }
}
