import Moya

enum ViaplayTarget {
  case sections
  case section(path: String)
}

extension ViaplayTarget: TargetType {
  
  var baseURL: URL { URL(string: "https://content.viaplay.se/ios-se")! }
  
  var path: String {
    guard
      case let .section(path) = self else { return "" }
    return path
  }
  
  var method: Method { .get }
  
  var task: Task { .requestPlain }
  
  var headers: [String : String]? { nil }
}
