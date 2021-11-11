import UIKit

final class SectionsNavigator: Mixin<UINavigationController?>, NavigatorProtocol {
  
  enum Destination { case details(sectionId: String) }
  
  func navigate(to destination: Destination) {
    switch destination {
    case let .details(sectionId):
      base?
        .pushViewController(
          Factory.shared.createDetailsViewController(sectionId: sectionId),
          animated: true
        )
    }
  }
}
