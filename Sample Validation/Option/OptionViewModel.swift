import SwiftUI
import Combine

class OptionViewModel: ObservableObject {
    @Published var email = ""
    @Published var phone = ""
    @Published var showAlert = false
    @Published var alert = { Alert(title: Text("")) }

    let validator = OptionValidator()

    func didTapValidate() {
        validator
            .validate(email: validator.validate(email: email),
                      phone: validator.validate(phone: phone))
            .fold({ [weak self] in self?.error() },
                  { [weak self] in self?.success(form: $0) })
    }

    func success(form: Form) {
        self.alert = { Alert(title: Text("Success!"), message: Text("Your email is \(form.email) and your phone is \(form.phone)"), dismissButton: .default(Text("Ok"))) }
        self.showAlert = true
    }

    func error() {
        self.alert = { Alert(title: Text("Failed!"), message: Text("Something got wrong with validation! Try again"), dismissButton: .default(Text("Ok"))) }
        self.showAlert = true
    }
}
