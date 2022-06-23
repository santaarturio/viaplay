//
//  ViaplaySection+CoreDataClass.swift
//  viaplay
//
//  Created by Artur Nikolaienko on 10.11.2021.
//
//

import Foundation
import CoreData

@objc(ViaplaySection)
public class ViaplaySection: NSManagedObject {

  func configure(preview: DTO.Sections.Links.Section) {
    self.id = preview.id
    self.title = preview.title
    
    let _path = String(preview.href.split(separator: "/").last ?? "")
    self.path = _path
      .range(of: "{?dtg,productsPerPage}")
      .map { range in _path.replacingCharacters(in: range, with: "") } ?? ""
  }
  
  func configure(section: DTO.Section) {
    self.text = section.description
    self.sectionType = section.pageType
  }
}
