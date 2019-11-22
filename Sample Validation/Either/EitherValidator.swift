import Foundation
import Bow

struct EitherValidator {
    func validate(email: String) -> Either<ValidationError, String> {
        guard email.isValidEmail() else {
            return Either.left(.notValidEmail)
        }
        return Either.right(email)
    }

    func validate(phone: String) -> Either<ValidationError, String> {
        guard phone.isValidPhone() else {
            return Either.left(.notValidPhone)
        }
        return Either.right(phone)
    }

    func validate(email: Either<ValidationError, String>, phone: Either<ValidationError, String>) -> Either<ValidationError, Form> {
        Either.fix(Either<ValidationError, Form>.map(email, phone, Form.init))
    }
}
