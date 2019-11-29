import SwiftUI

struct ErrorText: View {
    private let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .font(Font.system(size: 11,
                              weight: .semibold,
                              design: .monospaced))
    }
}
