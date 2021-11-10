extension DTO {
  
  struct Sections: Codable {
    let links: Links; struct Links: Codable {
      let sections: [Section]; struct Section: Codable {
        let id: String
        let title: String
        let href: String
      }
      
      enum CodingKeys: String, CodingKey {
        case sections = "viaplay:sections"
      }
    }
    
    enum CodingKeys: String, CodingKey {
      case links = "_links"
    }
  }
}
