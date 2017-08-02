import StrongJSON
import XCTest


class DiscardJSONTests: XCTestCase {
    func testNumbers() {
        let array = NSArray(array: ["fail" as NSString])

        XCTAssertThrowsError(try JSONArray<Int>.deserialize(array))
        XCTAssertNoThrow(try JSONArray<DiscardJSON>.deserialize(array))
    }
}
