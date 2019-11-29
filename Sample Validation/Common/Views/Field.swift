import SwiftUI

struct Field: View {
    let placeholder: String
    let text: Binding<String>

    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self.text = text
    }

    var body: some View {
        HStack {
            TextField(placeholder, text: text)
                .padding([.leading, .trailing], 20)
                .padding([.top, .bottom], 10)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}
