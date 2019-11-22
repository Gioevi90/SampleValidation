import Foundation
import Bow

struct OptionValidator {
    func validate(email: String) -> Option<String> {
        guard email.isValidEmail() else {
            return Option.none()
        }
        return Option.some(email)
    }

    func validate(phone: String) -> Option<String> {
        guard phone.isValidPhone() else {
            return Option.none()
        }
        return Option.some(phone)
    }

    func validate(email: Option<String>, phone: Option<String>) -> Option<Form> {
        Option.fix(Option<Form>.map(email, phone, Form.init))
    }
}
