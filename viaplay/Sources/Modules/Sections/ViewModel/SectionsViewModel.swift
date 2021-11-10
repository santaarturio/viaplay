import Combine

extension Sections {
  
  final class ViewModel {
    private(set) var sections: [ViaplaySection] = [] { didSet { reload.send() } }
    
    let reload: PassthroughSubject<Void, Never> = .init()
    let details: PassthroughSubject<Int, Never> = .init()
    
    private let dataBase: ViaplayDataBaseProtocol
    private let api: ViaplayAPIProtocol
    private let navigator: SectionsNavigator
    
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

extension Sections.ViewModel {
  
  func setup() {
    dataBase
      .sectionsPublisher
      .sink { [weak self] sections in self?.sections = sections }
      .store(in: &cancellables)
    
    details
      .compactMap { [weak self] index in self?.sections[index].path }
      .map { .details(path: $0) }
      .sink(receiveValue: weakify(SectionsNavigator.navigate, object: navigator))
      .store(in: &cancellables)
    
    api
      .sections()
      .sink(
        receiveCompletion: { _ in },
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
