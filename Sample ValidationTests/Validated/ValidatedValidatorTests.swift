import XCTest
import Bow
@testable import Sample_Validation

class ValidatedValidatorTests: XCTestCase {
    var sut: ValidatedValidator?

    override func setUp() {
        sut = ValidatedValidator()
    }

    func testValidateEmailWithValidEmailReturnsEitherRight(){
        let input = "test@test.com"
        let result = sut?.validate(email: input)
        XCTAssertEqual(result, Validated.valid(input))
    }

    func testValidateEmailWithinvalidEmailReturnsEitherLeftNotValidEmail(){
        let input = "test@test:com"
        let result = sut?.validate(email: input)
        XCTAssertEqual(result, Validated.invalid([.notValidEmail]))
    }

    func testValidatePhoneWithValidPhoneReturnsEitherRight(){
        let input = "3420192883"
        let result = sut?.validate(phone: input)
        XCTAssertEqual(result, Validated.valid(input))
    }

    func testValidatePhoneWithInvalidPhoneReturnsEitherLeftNotValidPhone(){
        let input = "12a9384762"
        let result = sut?.validate(phone: input)
        XCTAssertEqual(result, Validated.invalid([.notValidPhone]))
    }

    func testValidateInvalidEmailAndValidPhoneReturnsValidatedInvalidEmail() {
        let email = Validated<[ValidationError], String>.invalid([.notValidEmail])
        let phone = Validated<[ValidationError], String>.valid("3420192883")
        let result = sut?.validate(email: email, phone: phone)
        XCTAssertEqual(result, Validated.invalid([.notValidEmail]))
    }

    func testValidateValidEmailAndInvalidPhoneReturnsValidatedInvalidPhone() {
        let email = Validated<[ValidationError], String>.valid("test@test.com")
        let phone = Validated<[ValidationError], String>.invalid([.notValidPhone])
        let result = sut?.validate(email: email, phone: phone)
        XCTAssertEqual(result, Validated.invalid([.notValidPhone]))
    }

    func testValidateInvalidEmailAndInvalidPhoneReturnsTwoErrorsInValidated() {
        let email = Validated<[ValidationError], String>.invalid([.notValidEmail])
        let phone = Validated<[ValidationError], String>.invalid([.notValidPhone])
        let result = sut?.validate(email: email, phone: phone)
        XCTAssertEqual(result, Validated.invalid([.notValidPhone, .notValidEmail]))
    }

    func testValidateValidEmailAndValidPhoneReturnsValidatedValid() {
        let email = Validated<[ValidationError], String>.valid("test@test.com")
        let phone = Validated<[ValidationError], String>.valid("3420192883")
        let result = sut?.validate(email: email, phone: phone)
        XCTAssertEqual(result, Validated.valid(Form(email: "test@test.com", phone: "3420192883")))
    }
}
