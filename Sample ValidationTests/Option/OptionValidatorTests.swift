import XCTest
import Bow
@testable import Sample_Validation

class OptionValidatorTests: XCTestCase {
    var sut: OptionValidator?

    override func setUp() {
        sut = OptionValidator()
    }

    func testValidateEmailWithValidEmailReturnsOptionSome(){
        let input = "test@test.com"
        let result = sut?.validate(email: input)
        XCTAssertEqual(result, Option.some(input))
    }

    func testValidateEmailWithinvalidEmailReturnsOptionNone(){
        let input = "test@test:com"
        let result = sut?.validate(email: input)
        XCTAssertEqual(result, Option.none())
    }

    func testValidatePhoneWithValidPhoneReturnsOptionSome(){
        let input = "3420192883"
        let result = sut?.validate(phone: input)
        XCTAssertEqual(result, Option.some(input))
    }

    func testValidatePhoneWithInvalidPhoneReturnsOptionNone(){
        let input = "12a9384762"
        let result = sut?.validate(phone: input)
        XCTAssertEqual(result, Option.none())
    }

    func testValidateInvalidEmailAndValidPhoneReturnsOptionNone() {
        let email = Option<String>.none()
        let phone = Option.some("3420192883")
        let result = sut?.validate(email: email, phone: phone)
        XCTAssertEqual(result, Option.none())
    }

    func testValidateValidEmailAndInvalidPhoneReturnsOptionNone() {
        let email = Option.some("test@test.com")
        let phone = Option<String>.none()
        let result = sut?.validate(email: email, phone: phone)
        XCTAssertEqual(result, Option.none())
    }

    func testValidateInvalidEmailAndInvalidPhoneReturnsOptionNone() {
        let email = Option<String>.none()
        let phone = Option<String>.none()
        let result = sut?.validate(email: email, phone: phone)
        XCTAssertEqual(result, Option.none())
    }

    func testValidateValidEmailAndValidPhoneReturnsOptionSome() {
        let email = Option.some("test@test.com")
        let phone = Option.some("3420192883")
        let result = sut?.validate(email: email, phone: phone)
        XCTAssertEqual(result, Option.some(Form.init(email: "test@test.com", phone: "3420192883")))
    }
}

extension Form: Equatable {
    public static func == (lhs: Form, rhs: Form) -> Bool {
        return lhs.email == rhs.email && lhs.phone == rhs.phone
    }
}
