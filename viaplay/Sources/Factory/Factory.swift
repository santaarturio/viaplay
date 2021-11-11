import UIKit

final class Factory {
  static let shared = Factory()
  
  private let navigationController = UINavigationController()
  
  func createRootViewController() -> UIViewController {
    navigationController.viewControllers = [
      Sections
        .ViewController(
          viewModel: Sections
            .ViewModel(
              dataBase: DataBase.viaplay,
              api: ViaplayAPI(),
              navigator: SectionsNavigator { [weak self] in self?.navigationController }
            )
        )
    ]
    return navigationController
  }
  
  func createDetailsViewController(sectionId: String) -> UIViewController {
    Details
      .ViewController(
        viewModel: Details
          .ViewModel(
            sectionId: sectionId,
            dataBase: DataBase.viaplay,
            api: ViaplayAPI()
          )
      )
  }
}
