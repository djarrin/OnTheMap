//
//  StudentLocationResponse.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/6/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import Foundation

struct StudentLocationResponse: Codable {
    let results: [StudentListing]
}
