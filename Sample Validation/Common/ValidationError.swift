import Foundation

enum ValidationError: Error {
    case notValidEmail
    case notValidPhone
}

extension ValidationError {
    var localizedDescription: String {
        switch self {
        case .notValidEmail:
            return "The inserted email is not valid! Try again"
        case .notValidPhone:
            return "The inserted phone is not valid! Try again"
        }
    }
}
