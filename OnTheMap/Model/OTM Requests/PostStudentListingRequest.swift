//
//  PostStudentListingRequest.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/11/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import Foundation

struct PostStudentListingRequest: Codable {
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
}
