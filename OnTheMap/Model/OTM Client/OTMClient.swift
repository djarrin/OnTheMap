//
//  OTMClient.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/5/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import Foundation

class OTMClient {
    
    struct Auth {
        static var registered: Bool = false
        static var key: String = ""
        static var id: String = ""
        static var expiration: String = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        static let signUpUrl = "https://auth.udacity.com/sign-up"
        
        case login
        case signUp
        
        
        var stringValue: String {
            switch self {
            case .login: return Endpoints.base + "/session"
            case .signUp: return Endpoints.signUpUrl
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let body = UdacityLoginRequest(udacity: LoginParams(username: username, password: password))
        _post(url: Endpoints.login.url, responseType: UdacityLoginResponse.self, body: body) { (response, error) in
            if let response = response {
                Auth.registered = response.account.registered
                Auth.key = response.account.key
                Auth.id = response.session.id
                Auth.expiration = response.session.expiration
                
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    @discardableResult class func _post<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            // Udacity put some odd characters at the beggening of the response for security reasons?
            let range = 5..<data.count
            let strippedData = data.subdata(in: range)
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: strippedData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(OTMResponse.self, from: strippedData)
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
            
        }
        task.resume()
        
        return task
    }
}
