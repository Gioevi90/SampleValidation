import Foundation
import SwiftUI

struct MainViewModel {
    let items = ["Option", "Either", "Validated"]
    let links = ["Option": AnyView(OptionView()),
                 "Either": AnyView(EitherView()),
                 "Validated": AnyView(ValidatedView())]

    func didTapItem(_ item: String) -> AnyView? {
        links[item]
    }
}
