import UIKit
import Combine

enum Sections { }

extension Sections {
  
  final class ViewController: UITableViewController {
    private let viewModel: Sections.ViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    init(viewModel: Sections.ViewModel) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
      setupView()
    }
  }
}

// MARK: - ViewCode
extension Sections.ViewController: ViewCode {
  
  func setupViewHierarhcy() { }
  
  func setupConstraints() { }
  
  func setupAdditionalConfigurations() {
    title = "Sections"
    
    tableView.separatorStyle = .none
    tableView
      .register(
        Sections.TableCell.self,
        forCellReuseIdentifier: String(describing: Sections.TableCell.self))
    
    viewModel
      .reload
      .dropFirst()
      .sink { [weak self] in self?.tableView.reloadData() }
      .store(in: &cancellables)
  }
}

// MARK: - DataSource & Delegate
extension Sections.ViewController {
  
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int { viewModel.sections.count }
  
  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard
      let cell = tableView
        .dequeueReusableCell(
          withIdentifier: String(describing: Sections.TableCell.self)
        ) as? Sections.TableCell else { return .init() }
    cell.configure(section: viewModel.sections[indexPath.row])
    return cell
  }
  
  override func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) { viewModel.details.send(indexPath.row) }
}
