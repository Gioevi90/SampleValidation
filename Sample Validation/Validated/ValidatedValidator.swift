import Foundation
import Bow

struct ValidatedValidator {
    func validate(email: String) -> Validated<[ValidationError], String> {
        guard email.isValidEmail() else {
            return Validated.invalid([ValidationError.notValidEmail])
        }
        return Validated.valid(email)
    }

    func validate(phone: String) -> Validated<[ValidationError], String> {
        guard phone.isValidPhone() else {
            return Validated.invalid([.notValidPhone])
        }
        return Validated.valid(phone)
    }

    func validate(email: Validated<[ValidationError], String>, phone: Validated<[ValidationError], String>) -> Validated<[ValidationError], Form> {
        Validated.fix(ValidatedPartial.map(email, phone, Form.init))
    }
}

