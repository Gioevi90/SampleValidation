import SwiftUI

struct MainView: View {
    @State var viewModel = MainViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Functional Validation With Bow")
                Spacer()
                VStack {
                    Separator()
                    ForEach(viewModel.items, id: \.self) { item in
                        NavigationLink(destination: self.viewModel.didTapItem(item)) {
                            MainCell(item)
                        }
                    }.frame(height: 55)
                }
                Spacer()
            }.foregroundColor(Color(UIColor.black))
        }
    }
}
