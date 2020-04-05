//
//  UdacityLoginResponse.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/5/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import Foundation

struct account: Codable {
    let registered: Bool
    let key: String
}

struct session: Codable {
    let id: String
    let expiration: String
}

struct UdacityLoginResponse: Codable {
    let account: account
    let session: session
}
