import XCTest
@testable import CoreUITests

final class CoreUITestsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CoreUITests().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
