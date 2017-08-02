import StrongJSON
import XCTest


private func ==<T: Equatable>(lhs: [T?], rhs: [T?]) -> Bool {
    if lhs.count != rhs.count {
        return false
    }

    for (l, r) in zip(lhs, rhs) where l != r {
        return false
    }

    return true
}


class NullableDeserializeTests: XCTestCase {
    func testNull() {
        XCTAssertEqual(try JSONNullable<String>.parse("null"), nil)
    }

    func testValue() {
        XCTAssertEqual(try JSONNullable<String>.parse("\"Ayyy\""), "Ayyy")
        XCTAssertEqual(try JSONNullable<Int>.parse("0"), 0)
    }

    func testWrongType() {
        XCTAssertThrowsError(try JSONNullable<String>.parse("0"))
    }

    func testArrayOfNullables() {
        XCTAssert(try JSONArray<JSONNullable<Int>>.parse("[0, null]") == [0, nil])
    }

    func testNullableArray() throws {
        let x = try JSONNullable<JSONArray<Int>>.parse("[0, 1]")

        XCTAssertNotNil(x)
        XCTAssertEqual(x!, [0, 1])
    }
}
