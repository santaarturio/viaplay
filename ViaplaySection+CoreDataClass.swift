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
    self.path = String(preview.href.split(separator: "/").last ?? "")
  }
  
  func configure(section: DTO.Section) {
    self.title = section.title
    self.text = section.description
  }
}
