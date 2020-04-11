//
//  UserResponse.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/11/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import Foundation

struct UserResponse: Codable {
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
        case firstName = "first_name"
    }
}
