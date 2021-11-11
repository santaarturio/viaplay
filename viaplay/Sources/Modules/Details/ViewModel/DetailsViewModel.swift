import Combine

extension Details {
  
  struct Props {
    let title: String?
    let text: String?
    
    static let defaultValue: Self = .init(title: nil, text: nil)
  }
}

extension Details {
  
  final class ViewModel {
    private let sectionId: String
    private var path = "" { didSet { fetchDetails(path: path) } }
    
    private let dataBase: ViaplayDataBaseProtocol
    private let api: ViaplayAPIProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    let props = CurrentValueSubject<Props, Never>(.defaultValue)
    
    init(
      sectionId: String,
      dataBase: ViaplayDataBaseProtocol,
      api: ViaplayAPIProtocol
    ) {
      self.sectionId = sectionId
      self.dataBase = dataBase
      self.api = api
      
      setup()
    }
  }
}

private extension Details.ViewModel {
  
  func setup() {
    dataBase
      .updateSection(id: sectionId) { [weak self] section in
        self?
          .props
          .send(Details.Props(title: section.title, text: section.text))
        
        section.path.map { path in self?.path = path }
      }
  }
  
  func fetchDetails(path: String) {
    let sectionId = sectionId
    
    api
      .section(path: path)
      .sink(
        receiveCompletion: { _ in },
        receiveValue: { [weak self] dto in
          self?
            .dataBase
            .updateSection(id: sectionId) { section in
              section.configure(section: dto)
              
              self?
                .props
                .send(Details.Props(title: section.title, text: section.text))
            }})
      .store(in: &cancellables)
  }
}
