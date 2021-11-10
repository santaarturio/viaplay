import UIKit

final class SectionsNavigator: Mixin<UINavigationController?>, NavigatorProtocol {
  
  enum Destination { case details(path: String) }
  
  func navigate(to destination: Destination) {
    switch destination {
    case let .details(path):
      base?
        .pushViewController(
          Factory.shared.createDetailsViewController(path: path),
          animated: true
        )
    }
  }
}
