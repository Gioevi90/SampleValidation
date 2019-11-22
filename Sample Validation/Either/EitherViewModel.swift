import SwiftUI
import Combine

class EitherViewModel: ObservableObject {
    @Published var email = ""
    @Published var phone = ""
    @Published var showAlert = false
    @Published var alert = { Alert(title: Text("")) }

    let validator = EitherValidator()

    func didTapValidate() {
        validator
            .validate(email: validator.validate(email: email),
                      phone: validator.validate(phone: phone))
            .fold({ [weak self] in self?.error(error: $0) },
                  { [weak self] in self?.success(form: $0) })
    }

    func success(form: Form) {
        self.alert = { Alert(title: Text("Success!"), message: Text("Your email is \(form.email) and your phone is \(form.phone)"), dismissButton: .default(Text("Ok"))) }
        self.showAlert = true
    }

    func error(error: ValidationError) {
        self.alert = { Alert(title: Text("Failed!"), message: Text(error.localizedDescription), dismissButton: .default(Text("Ok"))) }
        self.showAlert = true
    }
}
