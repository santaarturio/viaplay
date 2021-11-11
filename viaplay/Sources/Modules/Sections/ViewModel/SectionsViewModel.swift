import Combine
import struct Result.AnyError

extension Sections {
  
  struct Props {
    let sections: [ViaplaySection]
    let details: PassthroughSubject<Int, Never>
    let onError: PassthroughSubject<String?, Never>
    
    static let defaultValue: Self = .init(sections: [], details: .init(), onError: .init())
  }
}

extension Sections {
  
  final class ViewModel {
    private let dataBase: ViaplayDataBaseProtocol
    private let api: ViaplayAPIProtocol
    private let navigator: SectionsNavigator
    
    let props = CurrentValueSubject<Props, Never>(.defaultValue)
    private var cancellables: Set<AnyCancellable> = []
    
    init(
      dataBase: ViaplayDataBaseProtocol,
      api: ViaplayAPIProtocol,
      navigator: SectionsNavigator
    ) {
      self.dataBase = dataBase
      self.api = api
      self.navigator = navigator
      
      setup()
    }
  }
}

private extension Sections.ViewModel {
  
  func sendProps(sections: [ViaplaySection]) {
    let details = PassthroughSubject<Int, Never>()
    details
      .compactMap { index in sections[index].id }
      .map { .details(sectionId: $0) }
      .sink(receiveValue: weakify(SectionsNavigator.navigate, object: navigator))
      .store(in: &cancellables)
    
    let onError = PassthroughSubject<String?, Never>()
    
    props.send(Sections.Props(sections: sections, details: details, onError: onError))
  }
  
  func handleCompletion(_ completion: Subscribers.Completion<AnyError>) {
    guard
      case let .failure(error) = completion else { return }
    props.value.onError.send(error.localizedDescription)
  }
  
  func setup() {
    dataBase
      .sectionsPublisher
      .sink(receiveValue: weakify(Sections.ViewModel.sendProps, object: self))
      .store(in: &cancellables)
    
    api
      .sections()
      .sink(
        receiveCompletion: weakify(Sections.ViewModel.handleCompletion, object: self),
        receiveValue: { [weak self] sections in
          sections
            .links
            .sections
            .forEach { section in
              self?.dataBase
              .updateSection(id: section.id) { $0.configure(preview: section)} }
        })
      .store(in: &cancellables)
  }
}
