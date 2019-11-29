import SwiftUI

struct ValidatedView: View {
    @ObservedObject var viewModel = ValidatedViewModel()

    var body: some View {
        VStack {
            Field("Enter the email", text: $viewModel.email)
            ErrorText(viewModel.emailError)
            Field("Enter the phone number", text: $viewModel.phone)
            ErrorText(viewModel.phoneError)
            ValidateButton("Validate", action: {
                self.viewModel.didTapValidate()
            })
            Spacer()
        }.alert(isPresented: $viewModel.showAlert, content: {
            viewModel.alert()
        })
    }
}
