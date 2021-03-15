////
////  Protocols.swift
////  Services
////
////  Created by Camryn Crowder on 12/27/20.
////  Copyright © 2020 Capsule. All rights reserved.
////
//
//import Foundation
//import Alamofire
//
//
//protocol HTTPMethod: String {
//}
//
//protocol NetworkManagerProtocol {
//    func get(completionBlock: @escaping (AFDataResponse<Data>) -> Void)
//}
//
//class NetworkManager {
//
//
//    func loadData<T: Codable>(url: String, type: T.Type) {
//        let request = AF.request(url, parameters: ["foo":"bar"])
////        var data:[T] = [T]()
//        request
//            .validate(statusCode: 200..<300)
//            .validate(contentType: ["application/json"])
//            .response(completionHandler: {complete in
//                print("done")
//                print(request.retryCount)
//            })
//            .responseDecodable(of: ApiModel<T>.self) { (response) in
//            print(response.response?.headers)
//            print(">>>>>>>>>>")
//            print(response.result)
//            print(">>>>>>>>>>")
//            print(response)
//            guard let apiData = response.value
//            else {
//                print("else block")
//                return
//            }
////            data = [apiData.data]
//            }
//    }
//
//    func getHeader() -> HTTPHeaders {
//        if auth != nil {
//            let headers : HTTPHeaders  = [
//                "Authorization": "Bearer \(String(describing: auth!.access))",
//                "Content-Type":"application/json"
//            ]
//            return headers
//        }
//        else {
//            let headers : HTTPHeaders  = ["Content-Type":"application/json"]
//            return headers
//        }
//    }
//
//    func authLogin() {
//        let parameters: Parameters = ["username": "camryn", "password": "0010110"]
//        AF.request("http://172.16.0.3:8000/api/token/", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: getHeader())
//            .responseData { [self] response in
//                switch response.result {
//                case .success(let data):
//                    do {
//                        let decoder = JSONDecoder()
//                        let user = try decoder.decode(Auth.self, from: data)
//                        self.auth = user
//                        print("logged in")
//                    } catch  {
//                        print("error")
//                    }
//                case .failure(let error):
//                    print(error)
//                    print("cant login")
//                }
//            }
//    }
//
//
//
//    //    var session: Session?
////    var router: APIRouter?
////
////    required init(session: Session, router: APIRouter) {
////        self.session = session
////        self.router = router
////    }
////
////    func get(completionBlock: @escaping (AFDataResponse<Data>) -> Void) {
////        session?.request(router!).responseData(completionHandler: {data in
////            completionBlock(data)
////        })
////    }
//}
//
//class RequestModel: NSObject {
//
//    // MARK: - Properties
//    var path: String {
//        return ""
//    }
//    var parameters: [String: Any?] {
//        return [:]
//    }
//    var headers: [String: String] {
//        return [:]
//    }
//    var method: RequestHTTPMethod {
//        return body.isEmpty ? RequestHTTPMethod.get : RequestHTTPMethod.post
//    }
//    var body: [String: Any?] {
//        return [:]
//    }
//
//  // (request, response)
//    var isLoggingEnabled: (Bool, Bool) {
//        return (true, true)
//    }
//}
//
//struct ResponseModel<T: Codable>: Codable {
//
//    // MARK: - Properties
//    var isSuccess: Bool
//    var message: String
//    var error: ErrorModel {
//        return ErrorModel(message)
//    }
//    var rawData: Data?
//    var data: T?
//    var json: String? {
//        guard let rawData = rawData else { return nil }
//        return String(data: rawData, encoding: String.Encoding.utf8)
//    }
//    var request: RequestModel?
//
//    public init(from decoder: Decoder) throws {
//        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
//
//        isSuccess = (try? keyedContainer.decode(Bool.self, forKey: CodingKeys.isSuccess)) ?? false
//        message = (try? keyedContainer.decode(String.self, forKey: CodingKeys.message)) ?? ""
//        data = try? keyedContainer.decode(T.self, forKey: CodingKeys.data)
//    }
//}
//
//
//class ServiceManager {
//
//    // MARK: - Properties
//    public static let shared: ServiceManager = ServiceManager()
//
//    public var baseURL: String = "https://api.binance.com/api/v3"
//}
//
//// MARK: - Public Functions
//extension ServiceManager {
//
//    func sendRequest<T: Codable>(request: RequestModel, completion: @escaping(Swift.Result<T, ErrorModel>) -> Void) {
//        if request.isLoggingEnabled.0 {
//            LogManager.req(request)
//        }
//
//        /// Comment for rest service
//        let data = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Response", ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
//
//        /// Uncomment for rest service
////        URLSession.shared.dataTask(with: request.urlRequest()) { data, response, error in
////            guard let data = data, var responseModel = try? JSONDecoder().decode(ResponseModel<T>.self, from: data) else {
//            guard var responseModel = try? JSONDecoder().decode(ResponseModel<T>.self, from: data) else {
//                let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)
//                LogManager.err(error)
//
//                completion(Result.failure(error))
//                return
//            }
//
//            responseModel.rawData = data
//            responseModel.request = request
//
//            if request.isLoggingEnabled.1 {
//                LogManager.res(responseModel)
//            }
//
//            if responseModel.isSuccess, let data = responseModel.data {
//                completion(Result.success(data))
//            } else {
//                completion(Result.failure(ErrorModel.generalError()))
//            }
//
//        /// Uncomment for rest service
////        }.resume()
//    }
//}
//
//protocol APIRouter: URLRequestConvertible {
//    var method: HTTPMethod { get }
//    var path: String { get }
//    var actionParameters: [String: Any] { get }
//    var baseURL: String { get }
//    var authHeader: HTTPHeaders? { get }
//    var encoding: ParameterEncoding { get }
//}
//
//extension APIRouter {
//    func asURLRequest() throws -> URLRequest {
//        let originalRequest = try URLRequest(
//            url: baseURL.appending(path),
//            method: method,
//            headers: authHeader)
//        let encodedRequest = try encoding.encode(
//            originalRequest,
//            with: actionParameters)
//        return encodedRequest
//    }
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
////protocol ApiRequest {
////    func loadData<T: Codable>(url: String, model: Any, type: T.Type)
////}
////
////protocol ApiResponse {
////    func sendData(url: String, data: Parameters, user: AuthUser)
////}
////
////extension ApiResponse {
////    func sendData(url: String, data: Parameters, user: AuthUser) {
////        let parameters: Parameters = data
////
////        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: user.getHeader())
////            .responseJSON { response in
////                //Need to program retry after failure
////                switch response.result {
////                case .success( _):
////                    do { print(response) }
////                case .failure(let error):
////                    print(error)
////                }
////            }
////    }
////}
//
//
////
////extension UIViewController {
////
////
////    func loadData<T: Codable>(url: String, type: T.Type) {
////        let request = AF.request(url, parameters: ["foo":"bar"])
//////        var data:[T] = [T]()
////        request
////            .validate(statusCode: 200..<300)
////            .validate(contentType: ["application/json"])
////            .response(completionHandler: {complete in
////                print("done")
////                print(request.retryCount)
////            })
////            .responseDecodable(of: ApiData<T>.self) { (response) in
////            print(response.response?.headers)
////            print(">>>>>>>>>>")
////            print(response.result)
////            print(">>>>>>>>>>")
////            print(response)
////            guard let apiData = response.value
////            else {
////                print("else block")
////                return
////            }
//////            data = [apiData.data]
////            }
////    }
////}
//
//class UserDefaultsManager {
//    enum Key: String {
//        case apiKey
//        case secretKey
//        case token
//        case isSignedIn
//    }
//    static let shared: UserDefaultsManager = {
//        return UserDefaultsManager()
//    }()
//    func getUserCredentials() -> (apiKey: String?, secretKey: String?) {
//        let apiKey = UserDefaults.standard.string(forKey: Key.apiKey.rawValue)
//        let secretKey = UserDefaults.standard.string(forKey: Key.secretKey.rawValue)
//        return (apiKey, secretKey)
//    }
//    func setUserCredentials(apiKey: String, secretKey: String) {
//        UserDefaults.standard.set(apiKey, forKey: Key.apiKey.rawValue)
//        UserDefaults.standard.set(secretKey, forKey: Key.secretKey.rawValue)
//        UserDefaults.standard.synchronize()
//    }
//    func getToken() -> String? {
//        return UserDefaults.standard.string(forKey: Key.token.rawValue)
//    }
//    func setToken(token: String) {
//        UserDefaults.standard.set(token, forKey: Key.token.rawValue)
//        UserDefaults.standard.synchronize()
//    }
//    func signInUser() {
//        UserDefaults.standard.set(true, forKey: Key.isSignedIn.rawValue)
//        UserDefaults.standard.synchronize()
//    }
//    func signOutUser() {
//        UserDefaults.standard.set(false, forKey: Key.isSignedIn.rawValue)
//        UserDefaults.standard.synchronize()
//    }
//    func isUserSignedIn() -> Bool {
//        return UserDefaults.standard.bool(forKey: Key.isSignedIn.rawValue)
//    }
//    func signIn(apiKey: String, secretKey: String, token: String) {
//        setUserCredentials(apiKey: apiKey, secretKey: secretKey)
//        setToken(token: token)
//        signInUser()
//    }
//}
