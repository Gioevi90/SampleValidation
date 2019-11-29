import SwiftUI

struct EitherView: View {
    @ObservedObject var viewModel = EitherViewModel()

    var body: some View {
        VStack {
            Field("Enter the email", text: $viewModel.email)
            Field("Enter the phone number", text: $viewModel.phone)
            ValidateButton("Validate", action: {
                self.viewModel.didTapValidate()
            })
            Spacer()
        }.alert(isPresented: $viewModel.showAlert, content: {
            viewModel.alert()
        })
    }
}
