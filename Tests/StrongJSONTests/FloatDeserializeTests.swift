import StrongJSON
import XCTest


extension FloatingPoint {
    var preciseString: String {
        if self == 0 { // exponent == Int.min
            return "0"
        }

        guard let fmtArg = self as? CVarArg else { // Float80
            return "\(self)"
        }

        let precision = self.exponent >= 0 ? 0 : -self.exponent

        // swiftlint:disable:next force_cast
        return String(format: "%.\(precision)f", fmtArg)
    }
}

class FloatDeserializeTests: XCTestCase {

    func testFloat32() {
        XCTAssertEqual(try Float32.parse("0"), Float32(0))
        XCTAssertEqual(try Float32.parse(Float32.greatestFiniteMagnitude.preciseString), Float32.greatestFiniteMagnitude)
        XCTAssertEqual(try Float32.parse(Float32.leastNonzeroMagnitude.preciseString), Float32.leastNonzeroMagnitude)
        XCTAssertEqual(try Float32.parse(Float32.leastNormalMagnitude.preciseString), Float32.leastNormalMagnitude)
        XCTAssertEqual(try Float32.parse(Float32.ulpOfOne.preciseString), Float32.ulpOfOne)
    }

    func testFloat64() {
        XCTAssertEqual(try Float64.parse("0"), Float64(0))
        // Foundation's JSON parser has a limit for number literal length, which these tests hit
//        XCTAssertEqual(try Float64.parse(Float64.greatestFiniteMagnitude.preciseString), Float64.greatestFiniteMagnitude)
//        XCTAssertEqual(try Float64.parse(Float64.leastNonzeroMagnitude.preciseString), Float64.leastNonzeroMagnitude)
//        XCTAssertEqual(try Float64.parse(Float64.leastNormalMagnitude.preciseString), Float64.leastNormalMagnitude)
        XCTAssertEqual(try Float64.parse(Float64.ulpOfOne.preciseString), Float64.ulpOfOne)
    }


    // MARK: RM ME

    func testIntegers() {
        for i in 0..<100 {
            XCTAssertEqual(try Float32.parse("\(+i)"), Float32(+i))
            XCTAssertEqual(try Float32.parse("\(-i)"), Float32(-i))

            XCTAssertEqual(try Float64.parse("\(+i)"), Float64(+i))
            XCTAssertEqual(try Float64.parse("\(-i)"), Float64(-i))
        }
    }

    func testNonIntegralValues() {
        for i in 1..<100 {
            XCTAssertEqual(try Float32.parse(Float32(1 / +i).preciseString), Float32(1 / +i))
            XCTAssertEqual(try Float32.parse(Float32(1 / -i).preciseString), Float32(1 / -i))

            XCTAssertEqual(try Float64.parse(Float64(1 / +i).preciseString), Float64(1 / +i))
            XCTAssertEqual(try Float64.parse(Float64(1 / -i).preciseString), Float64(1 / -i))
        }
    }

    func testBooleanValues() {
        XCTAssertThrowsError(try Float32.parse("false"))
        XCTAssertThrowsError(try Float64.parse("true"))
    }

    func testOutOfParserBounds() {
        // These should trigger errors in JSONSerialization.jsonObject(with:)
        XCTAssertThrowsError(try Float32.parse("1e-1000"))
        XCTAssertThrowsError(try Float32.parse("1e+1000"))

        XCTAssertThrowsError(try Float64.parse("1e-1000"))
        XCTAssertThrowsError(try Float64.parse("1e+1000"))
    }

    func testOutOfTypeBounds() {
        // These should trigger a JSONError
        XCTAssertThrowsError(try Float32.parse(Float64.leastNonzeroMagnitude.preciseString))
#if arch(i386) || arch(x86_64)
        XCTAssertThrowsError(try Float64.parse(Float80.leastNonzeroMagnitude.preciseString))
#endif

        XCTAssertThrowsError(try Float32.parse(Float64.greatestFiniteMagnitude.preciseString))
#if arch(i386) || arch(x86_64)
        XCTAssertThrowsError(try Float64.parse(Float80.greatestFiniteMagnitude.preciseString))
#endif
    }
}
