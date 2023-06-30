//
//  Facilities.swift
//
//  Created by C100-174 on 30/06/23
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Facilities: Codable {

  enum CodingKeys: String, CodingKey {
    case facilityId = "facility_id"
    case options
    case name
  }

  var facilityId: String?
  var options: [Options]?
  var name: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    facilityId = try container.decodeIfPresent(String.self, forKey: .facilityId)
    options = try container.decodeIfPresent([Options].self, forKey: .options)
    name = try container.decodeIfPresent(String.self, forKey: .name)
  }

}
