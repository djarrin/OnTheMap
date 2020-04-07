//
//  StudentListing.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/6/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import Foundation


struct StudentListing: Codable {
    let createdAt: String
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: String
}
