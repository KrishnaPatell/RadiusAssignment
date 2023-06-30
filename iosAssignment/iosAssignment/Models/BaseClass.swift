//
//  BaseClass.swift
//
//  Created by C100-174 on 30/06/23
//  Copyright (c) . All rights reserved.
//

import Foundation

struct BaseClass: Codable {

  enum CodingKeys: String, CodingKey {
    case facilities
    case exclusions
  }

  var facilities: [Facilities]?
  var exclusions: [[exclusion]]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    facilities = try container.decodeIfPresent([Facilities].self, forKey: .facilities)
    exclusions = try container.decodeIfPresent([[exclusion]].self, forKey: .exclusions)
  }

}
