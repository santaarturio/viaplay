import Combine

protocol ViaplayDataBaseProtocol {
  var sectionsPublisher: CurrentValueSubject<[ViaplaySection], Never> { get }
  func updateSection(id: String, _ configurationsHandler: @escaping (ViaplaySection) -> Void)
}
