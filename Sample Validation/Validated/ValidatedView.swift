import SwiftUI

struct ValidatedView: View {
    @ObservedObject var viewModel = ValidatedViewModel()

    var body: some View {
        VStack {
            TextField("Enter the email", text: $viewModel.email)
            Text(viewModel.emailError)
            TextField.init("Enter the phone number", text: $viewModel.phone)
            Text(viewModel.phoneError)
            Button("Validate", action: {
                self.viewModel.didTapValidate()
            })
            Spacer()
        }.alert(isPresented: $viewModel.showAlert, content: {
            viewModel.alert()
        })
    }
}
