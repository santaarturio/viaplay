extension DTO {
  
  struct Section: Codable {
    let id: String
    let pageType: String
    let title: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
      case id = "sectionId"
      case pageType, title, description
    }
  }
}
