import StrongJSON
import XCTest


class OptionalDeserializeTests: XCTestCase {
    func testNone() {
        XCTAssertNil(try JSONOptional<String>.deserialize(key: "", of: NSDictionary()))
    }

    func testSome() {
        let dict: [String: Any] = [
            "Ayy": "LMAO",
            "0": 1,
        ]

        let nsdict = dict as NSDictionary
        XCTAssertEqual(try JSONOptional<String>.deserialize(key: "Ayy", of: nsdict), "LMAO")
        XCTAssertEqual(try JSONOptional<Int>.deserialize(key: "0", of: nsdict), 1)
    }

    func testSomeNullable() throws {
        let dict = ["Ayy": nil] as [String: Any?]

        let nsdict = dict as NSDictionary
        let x = try JSONOptional<JSONNullable<Int>>.deserialize(key: "Ayy", of: nsdict)

        XCTAssertNil(x!)
    }

    func testSomeWrongType() {
        let dict = NSDictionary(dictionary: ["Ayy": "LMAO"])

        XCTAssertThrowsError(try JSONOptional<Int>.deserialize(key: "Ayy", of: dict))
    }

    func testNestedOptional() {
        let dict = NSDictionary(dictionary: [
            "0": NSDictionary(dictionary: ["1": 2]),
        ])

        XCTAssertEqual(try JSONOptional<Int>.deserialize(keyAt: ["0", "1"], of: dict), 2)
        XCTAssertEqual(try JSONOptional<Int>.deserialize(keyAt: ["0", "2"], of: dict), nil)
    }
}
