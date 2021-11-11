import UIKit
import Combine

enum Details { }

extension Details {
  
  final class ViewController: UIViewController {
    private let viewModel: Details.ViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var textLabel = UILabel()
    
    init(viewModel: Details.ViewModel) {
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
extension Details.ViewController: ViewCode {
  
  func setupViewHierarhcy() {
    view.addSubview(textLabel)
  }
  
  func setupConstraints() {
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
      textLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
      textLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
    ])
  }
  
  func setupAdditionalConfigurations() {
    view.backgroundColor = .systemBackground
    
    textLabel.numberOfLines = 0
    textLabel.font = UIFont.systemFont(ofSize: 20)
    
    viewModel
      .props
      .sink(receiveValue: weakify(Details.ViewController.render, object: self))
      .store(in: &cancellables)
  }
  
  private func render(props: Details.Props) {
    title = props.title
    textLabel.text = props.text
  }
}
