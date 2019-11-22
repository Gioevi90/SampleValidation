import SwiftUI
import Combine

struct OptionView: View {
    @ObservedObject var viewModel = OptionViewModel()

    var body: some View {
        VStack {
            TextField("Enter the email", text: $viewModel.email)
            TextField.init("Enter the phone number", text: $viewModel.phone)
            Button("Validate", action: {
                self.viewModel.didTapValidate()
            })
            Spacer()
        }.alert(isPresented: $viewModel.showAlert, content: {
            viewModel.alert()
        })
    }
}
