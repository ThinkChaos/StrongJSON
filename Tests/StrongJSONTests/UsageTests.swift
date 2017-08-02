import StrongJSON
import XCTest


// This is the JSON we're going to parse
let personJSON = "{\"name\": \"Adele\", \"phone\": 180023353, \"message\": \"Hello, it's me...\"}"


class Person: JSONRepresentable {

    let name: String
    let phone: UInt
    let message: String
    let age: UInt8?

    /// Initialises a Person with JSON data
    required init(jsonData: NSDictionary) throws {
        // Error handling takes place in a caller function, so we don't need pollute
        // this method. Still, we get the choice to do so if needed.
        self.name = try String.deserialize(key: "name", of: jsonData)
        self.phone = try UInt.deserialize(key: "phone", of: jsonData)
        self.message = try String.deserialize(key: "message", of: jsonData)
        self.age = try JSONOptional<UInt8>.deserialize(key: "age", of: jsonData)
    }
}


class UsageTests: XCTestCase {
    func testDeserializePerson() {
        var person: Person

        do {
            // Parse can also take a `NSData`. Useful when doing network requests!
            person = try Person.parseJSON(personJSON)
        } catch let error {
            // Here you would recover from the `JSONError`
            XCTFail("\(error)")
            return
        }

        // Now we can use our Person care free, taking full advantage of Swift's type system!
        XCTAssertEqual(person.name, "Adele")
        XCTAssertEqual(person.phone, 180023353)
        XCTAssertEqual(person.message, "Hello, it's me...")
        XCTAssertNil(person.age)
    }

    func testDeserializeInvalidPerson() {
        let json = "{\"name\": \"Someone\", \"phone\": \"This shouldn't be a string!\", \"message\": \"Hey\"}"

        XCTAssertThrowsError(try Person.parseJSON(json))
    }

    func testDeserializeIncompletePerson() {
        let json = "{\"name\": \"Someone\", \"message\": \"Hey\"}"

        // The JSON is missing "phone"
        XCTAssertThrowsError(try Person.parseJSON(json))
    }

    func testDeserializePersonWithAge() throws {
        let json = "{\"name\": \"Someone\", \"phone\": 123, \"message\": \"Hey\", \"age\": 18}"
        let person = try Person.parseJSON(json)

        XCTAssertEqual(person.name, "Someone")
        XCTAssertEqual(person.phone, 123)
        XCTAssertEqual(person.message, "Hey")
        XCTAssertEqual(person.age, 18)
    }
}
