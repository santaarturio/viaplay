import Combine
import struct Result.AnyError

final class ViaplayAPI: BaseAPI<ViaplayTarget>, ViaplayAPIProtocol {
  
  func sections() -> AnyPublisher<DTO.Sections, AnyError> {
    requestPublisher(.sections)
  }
  
  func section(path: String) -> AnyPublisher<DTO.Section, AnyError> {
    requestPublisher(.section(path: path))
  }
}
