/// Copyright (c) 2020 Capsule LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
//  NetworkManager.swift
//  network
//
//  Created by Camryn Crowder on 1/1/21.


import Foundation
import Alamofire


//MARK: - CONNECTIONOBSERVER
final class ConnectionManager {
    static let shared = ConnectionManager()
    let network = NetworkReachabilityManager(host: "www.google.com")
    var statusMessage = ""
    
    func startNetworkObserver() -> Bool {
        ((network?.startListening(onQueue: network!.reachabilityQueue, onUpdatePerforming: { status in
            switch status {
            case .notReachable:
                self.statusMessage = "The network is not reachable"
                
            case .unknown :
                self.statusMessage = "It is unknown whether the network is reachable"
                
            case .reachable(.ethernetOrWiFi):
                self.statusMessage = "The network is reachable over the WiFi connection"
                
            case .reachable(.cellular):
                self.statusMessage = "The network is reachable over the cellular connection"
                
            }
        })) != nil)
    }
}

//MARK: - NETWORKMANAGER
final class NetworkController: ObservableObject {
    @Published var isAuthenticated = false
    let baseUrl = "http://172.16.0.3:8000/test"
    var auth: Parameters = ["username": "camryn", "password": "0010110"]
    var encoding: ParameterEncoding! = URLEncoding.default
    
    static let shared = NetworkController()
    static let connectionStatus = ConnectionManager.shared
    
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.urlCache?.diskCapacity = 50000000
        configuration.urlCache?.memoryCapacity = 22000000
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = true
        let networkLogger = Logger()
        let interceptor = DataRequestInterceptor()
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify {_, response in
            let userInfo = ["date": Date()]
            print("\(response) - Response")
            return CachedURLResponse(response: response.response, data: response.data, userInfo: userInfo, storagePolicy: .notAllowed)
        })
        return Session(configuration: configuration, interceptor: interceptor, cachedResponseHandler: responseCacher, eventMonitors: [networkLogger])
    }()
    
    func loadData<T>(from: String, for: T.Type, using: HTTPMethod, parameters: Parameters = ["data":""], encoding: ParameterEncoding! = URLEncoding.default, completion: @escaping (Result<T, Error>) -> ()) where T: Codable {
        
        CacheController.shared.clearCache()
        
        //Decode GET Requests
        if using.rawValue == "GET" {
            
            //MARK: GET API Request
            let apiRequest = sessionManager.request(from, method: using, parameters: parameters, encoding: encoding)

            apiRequest
                .resume()
                .validate(contentType: ["application/json"])
                .responseDecodable(of: ApiModel<T>.self, completionHandler: { response in
                    switch response.result {
                    case .success(let data):
                        if let status = response.response?.statusCode {
                            switch status {
                            case 200..<300:
                                print("stat-\(status)")
                                completion(.success(data.data))
                            case 401:
                                print("failed>>>>>>>>>>>>>>>>>XX401")
                            case 500:
                                print(status)
                            default:
                                print(status)
                            }
                        }
                        
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
        }
        
        //Encode POST requests
        else {
            
            //MARK: POST API Request
            let apiRequest = sessionManager.request(from, method: using, parameters: parameters, encoding: JSONEncoding.default)
            
            apiRequest
                .resume()
                .validate(contentType: ["application/json"])
                .responseDecodable(of: ApiModel<T>.self, completionHandler: { response in
                    switch response.result {
                    case .success(let data):
                        if let status = response.response?.statusCode {
                            switch status {
                            case 200..<300:
                                print("stat-\(status)--------------")
                                completion(.success(data.data))
                            case 401:
                                print(status)
                            case 500:
                                print(status)
                            default:
                                print(status)
                            }
                        }
                        
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
        }
    }
    
    func authenticate() {
        let requestAuth = sessionManager.request("http://localhost:8000/api/token/", method: .post, parameters: auth, encoding: encoding)
        
        requestAuth
            .resume()
            .validate(contentType: ["application/json"])
            .authenticate(username: "camryn", password: "0010110")
            .responseDecodable(of: AuthTokens.self, completionHandler: { req in
            })
    }
}


struct User1:Codable
{
    var firstName: String
    var lastName: String
    var country: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case country
    }
}

//MARK: - INTERCEPTOR
class DataRequestInterceptor: RequestInterceptor {
    let retryLimit = 5
    let retryDelay: TimeInterval = 10
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        let urlRequest = urlRequest
        print("intercept")
        //    if let token = TokenManager.shared.fetchAccessToken() {
        //      urlRequest.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        //    }
        completion(.success(urlRequest)) }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        let response = request.task?.response as? HTTPURLResponse
        if let statusCode = response?.statusCode, (500...599).contains(statusCode), request.retryCount < retryLimit { completion(.retryWithDelay(retryDelay)) }
        else { return completion(.doNotRetry) }
    }
}

class RequestRouter {
    private init(){}
    
    var urlParameters = [String]()
    var path = ""
    var headers : HTTPHeaders  = ["Content-Type":"application/json"]
    
    static let shared = RequestRouter()
    
    //Converts URL to an array
    func generatePath(from: String) -> Array<String> {
        let array = from.components(separatedBy: "/")
        return array
    }
    
    //returns the method from the array
    func getMethod(from: [String]) -> HTTPMethod {
        var method:HTTPMethod {
            switch from[0] {
            case "get":
                return .get
            case "post":
                return .post
            case "options":
                return .options
            case "put":
                return .put
            case "delete":
                return .delete
            default:
                return .get
                
            }
        }
        
        return method
    }
    
    //Converts Array back to string with the path
    func getURL(){
        self.path = urlParameters.joined(separator:"/")
    }
    
    enum HTTPHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
}
