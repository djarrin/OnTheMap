//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/5/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import Foundation

struct UdacityLoginRequest: Codable {
    let udacity: LoginParams
}

struct LoginParams: Codable {
    let username: String
    let password: String
}
