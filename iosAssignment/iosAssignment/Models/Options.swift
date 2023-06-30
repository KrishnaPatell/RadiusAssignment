//
//  Options.swift
//
//  Created by C100-174 on 30/06/23
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Options: Codable {

  enum CodingKeys: String, CodingKey {
    case icon
    case name
    case id
  }

  var icon: String?
  var name: String?
  var id: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    icon = try container.decodeIfPresent(String.self, forKey: .icon)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    id = try container.decodeIfPresent(String.self, forKey: .id)
  }

}
