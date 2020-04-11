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
        static var firstName: String = ""
        static var lastName: String = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        static let signUpUrl = "https://auth.udacity.com/sign-up"
        
        case session
        case signUp
        case studentLocation(String)
        case user(String)
        
        
        var stringValue: String {
            switch self {
            case .session: return Endpoints.base + "/session"
            case .signUp: return Endpoints.signUpUrl
            case .studentLocation(let paramerters): return Endpoints.base + "/StudentLocation?" + paramerters
            case .user(let userID): return Endpoints.base + "/users/\(userID)"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let body = UdacityLoginRequest(udacity: LoginParams(username: username, password: password))
        _post(url: Endpoints.session.url, responseType: UdacityLoginResponse.self, body: body, stripResonse: true) { (response, error) in
            if let response = response {
                Auth.registered = response.account.registered
                Auth.key = response.account.key
                Auth.id = response.session.id
                Auth.expiration = response.session.expiration
    
                getUser(userID: Auth.key) { (response, error) in
                    if let response = response {
                        Auth.firstName = response.firstName
                        Auth.lastName = response.lastName
                        
                        completion(true, nil)
                    } else {
                        completion(false, error)
                    }
                }
            } else {
                completion(false, error)
            }
        }
    }
    
    class func studentListings(limit: Int? = 100, skip: Int? = nil, order: String? = nil, uniqueKey: String? = nil, completion: @escaping ([StudentListing], Error?) -> Void) {
        var paramStringArray: [String] = []
        if let limit = limit {
            paramStringArray.append(_: "limit=\(limit)")
        }
        if let skip = skip {
            paramStringArray.append(_: "skip=\(skip)")
        }
        if let order = order {
            paramStringArray.append(_: "order=\(order)")
        }
        if let uniqueKey = uniqueKey {
            paramStringArray.append(_: "uniqueKey=\(uniqueKey)")
        }
        let paramString = paramStringArray.joined(separator: "&")
        _get(url: Endpoints.studentLocation(paramString).url, response: StudentLocationResponse.self) { (response, error) in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
        
    }
    
    class func postStudentLocation(firstName: String, lastName: String, mapString: String, mediaURL: String, latitude: Double, longitude: Double, completion: @escaping (PostStudentListingResponse?, Error?) -> Void) {
        let uniqueId = UUID().uuidString
        let body = PostStudentListingRequest(uniqueKey: uniqueId, firstName: firstName, lastName: lastName, mapString: mapString, mediaURL: mediaURL, latitude: latitude, longitude: longitude)
        _post(url: Endpoints.studentLocation("").url, responseType: PostStudentListingResponse.self, body: body) { (response, error) in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func getUser(userID: String, completion: @escaping (UserResponse?, Error?) -> Void) {
        _get(url: Endpoints.user(userID).url, response: UserResponse.self, stripResonse: true) { (response, error) in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func logout(completion: @escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.session.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            Auth.expiration = ""
            Auth.key = ""
            Auth.registered = false
            Auth.id = ""
            DispatchQueue.main.async {
                completion(true, nil)
            }
        }
        task.resume()
    }
    
    @discardableResult class func _get<ResponseType: Decodable>(url: URL, response: ResponseType.Type, stripResonse: Bool = false, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            guard var data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            if stripResonse {
                data = stripData(data: data)
            }

            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(OTMResponse.self, from: data)
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
    
    @discardableResult class func _post<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, stripResonse: Bool = false, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard var data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            
            if stripResonse {
                data = stripData(data: data)
            }
            
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(OTMResponse.self, from: data)
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
    
    class func stripData(data: Data) -> Data {
        // Udacity put some odd characters at the beggening of the response for security reasons?
        let range = 5..<data.count
        return data.subdata(in: range)
    }
}
