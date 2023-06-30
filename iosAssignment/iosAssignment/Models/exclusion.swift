//
//  exclusion.swift
//  iosAssignment
//
//  Created by C100-174 on 30/06/23.
//

import Foundation
struct exclusion: Codable {

  enum CodingKeys: String, CodingKey {
    case facilityId = "facility_id"
    case optionsId = "options_id"
  }

  var facilityId: String?
  var optionsId: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      facilityId = try container.decodeIfPresent(String.self, forKey: .facilityId)
      optionsId = try container.decodeIfPresent(String.self, forKey: .optionsId)
  }

}
