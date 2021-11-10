import UIKit

final class Factory {
  static let shared = Factory()
  
  private var navigationController = UINavigationController()
  
  func createRootViewController() -> UIViewController {
    navigationController = UINavigationController()
    
    let viewModel = Sections
      .ViewModel(
        dataBase: DataBase.viaplay,
        api: ViaplayAPI(),
        navigator: SectionsNavigator { [weak self] in self?.navigationController })
    let viewController = Sections
      .ViewController(viewModel: viewModel)
    
    navigationController.viewControllers = [viewController]
    return navigationController
  }
  
  func createDetailsViewController(path: String) -> UIViewController { .init() }
}
