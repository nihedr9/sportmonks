import XCTest
@testable import sportmonks

final class sportmonksTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(sportmonks().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
