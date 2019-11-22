import SwiftUI

class ValidatedViewModel: ObservableObject {
    @Published var email = "" {
        didSet {
            emailError = ""
        }
    }
    @Published var phone = "" {
        didSet {
            phoneError = ""
        }
    }
    @Published var showAlert = false
    @Published var emailError = ""
    @Published var phoneError = ""
    @Published var alert = { Alert(title: Text("")) }

    let validator = ValidatedValidator()

    func didTapValidate() {
        validator
            .validate(email: validator.validate(email: email),
                      phone: validator.validate(phone: phone))
            .fold({ [weak self] in self?.error(errors: $0) },
                  { [weak self] in self?.success(form: $0) })
    }

    func success(form: Form) {
        self.alert = { Alert(title: Text("Success!"), message: Text("Your email is \(form.email) and your phone is \(form.phone)"), dismissButton: .default(Text("Ok"))) }
        self.showAlert = true
    }

    func error(errors: [ValidationError]) {
        if errors.contains(.notValidEmail) {
            emailError = "The inserted email is invalid! Please insert it again!"
        }
        if errors.contains(.notValidPhone) {
            phoneError = "The inserted phone is invalid! Please insert it again!"
        }
    }
}
