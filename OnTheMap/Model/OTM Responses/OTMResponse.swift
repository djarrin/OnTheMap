//
//  OTMResponse.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/5/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import Foundation

struct OTMResponse: Codable {
    let status: Int
    let error: String
}

extension OTMResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
