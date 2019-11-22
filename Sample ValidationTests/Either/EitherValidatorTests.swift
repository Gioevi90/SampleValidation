import XCTest
import Bow
@testable import Sample_Validation

class EitherValidatorTests: XCTestCase {
    var sut: EitherValidator?

    override func setUp() {
        sut = EitherValidator()
    }

    func testValidateEmailWithValidEmailReturnsEitherRight(){
        let input = "test@test.com"
        let result = sut?.validate(email: input)
        XCTAssertEqual(result, Either.right(input))
    }

    func testValidateEmailWithinvalidEmailReturnsEitherLeftNotValidEmail(){
        let input = "test@test:com"
        let result = sut?.validate(email: input)
        XCTAssertEqual(result, Either.left(.notValidEmail))
    }

    func testValidatePhoneWithValidPhoneReturnsEitherRight(){
        let input = "3420192883"
        let result = sut?.validate(phone: input)
        XCTAssertEqual(result, Either.right(input))
    }

    func testValidatePhoneWithInvalidPhoneReturnsEitherLeftNotValidPhone(){
        let input = "12a9384762"
        let result = sut?.validate(phone: input)
        XCTAssertEqual(result, Either.left(.notValidPhone))
    }

    func testValidateInvalidEmailAndValidPhoneReturnsOptionNone() {
        let email = Either<ValidationError, String>.left(.notValidEmail)
        let phone = Either<ValidationError, String>.right("3420192883")
        let result = sut?.validate(email: email, phone: phone)
        XCTAssertEqual(result, Either.left(.notValidEmail))
    }

    func testValidateValidEmailAndInvalidPhoneReturnsOptionNone() {
        let email = Either<ValidationError, String>.right("test@test.com")
        let phone = Either<ValidationError, String>.left(.notValidPhone)
        let result = sut?.validate(email: email, phone: phone)
        XCTAssertEqual(result, Either.left(.notValidPhone))
    }

    func testValidateInvalidEmailAndInvalidPhoneReturnsOptionNone() {
        let email = Either<ValidationError, String>.left(.notValidEmail)
        let phone = Either<ValidationError, String>.left(.notValidPhone)
        let result = sut?.validate(email: email, phone: phone)
        XCTAssertEqual(result, Either.left(.notValidEmail))
    }

    func testValidateValidEmailAndValidPhoneReturnsOptionSome() {
        let email = Either<ValidationError, String>.right("test@test.com")
        let phone = Either<ValidationError, String>.right("3420192883")
        let result = sut?.validate(email: email, phone: phone)
        XCTAssertEqual(result, Either.right(Form.init(email: "test@test.com", phone: "3420192883")))
    }
}
