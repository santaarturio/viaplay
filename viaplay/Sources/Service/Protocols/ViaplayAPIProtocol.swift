import Combine
import struct Result.AnyError

protocol ViaplayAPIProtocol {
  func sections() -> AnyPublisher<DTO.Sections, AnyError>
  func section(path: String) -> AnyPublisher<DTO.Section, AnyError>
}
