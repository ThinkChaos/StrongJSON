import StrongJSON
import XCTest


class JSONDeserializerUtilTests: XCTestCase {
    let dict = NSDictionary(dictionary: [
        "0": NSDictionary(dictionary: ["1": 2]),
    ])

    func testDeserializeMissingKey() {
        XCTAssertThrowsError(try Int.deserialize(key: "nope", of: dict))
        XCTAssertEqual(try Int.deserialize(key: "nope", of: dict, orDefault: 0), 0)
    }

    func testDeserializeKeyAtPath() throws {
        XCTAssertEqual(try Int.deserialize(keyAt: ["0", "1"], of: dict), 2)
        XCTAssertThrowsError(try Int.deserialize(keyAt: ["0", "1", "nop"], of: dict))
    }

    func testDeserializeMissingKeyAtPath() {
        XCTAssertThrowsError(try Int.deserialize(keyAt: ["0", "nope"], of: dict))
        XCTAssertEqual(try Int.deserialize(keyAt: ["0", "nope"], of: dict, orDefault: 0), 0)
    }
}
