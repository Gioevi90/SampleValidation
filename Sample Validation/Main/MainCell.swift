import SwiftUI

struct MainCell: View {
    private let title: String

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        VStack {
            Spacer()
            Text(title)
            Spacer()
            Separator()
        }
    }
}

struct Separator: View {
    var body: some View {
        Rectangle().frame(height: 1).background(Color(UIColor.black))
    }
}
