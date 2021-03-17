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
import Foundation
import Alamofire

class AuthUser: ObservableObject {
    @Published var auth: Auth?
    
    func getHeader() -> HTTPHeaders {
        if auth != nil {
            let headers : HTTPHeaders  = [
                "Authorization": "Bearer \(String(describing: auth!.access))",
                "Content-Type":"application/json"
            ]
            return headers
        }
        else {
            let headers : HTTPHeaders  = ["Content-Type":"application/json"]
            return headers
        }
    }
    func authLogin() {
        let parameters: Parameters = ["username": "camryn", "password": "0010110"]
        AF.request("http://172.16.0.3:8000/api/token/", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: getHeader())
            .responseData { [self] response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let user = try decoder.decode(Auth.self, from: data)
                        self.auth = user
                        print("logged in")
                    } catch  {
                        print("error")
                    }
                case .failure(let error):
                    print(error)
                    print("cant login")
                }
            }
    }
}

struct User {
    var id: Int
    var fname: String
    var lname: String
    var email: String
    var phone: Int
    var customer: String
}

struct Address {
    var id: Int
    var address1: String
    var address2: String
    var city: String
    var state: String
    var postal: String
}

struct Auth: Codable {
    var access: String
    var refresh: String
}
//struct profile {
//    var id: Int
//    var balance: Int
//    var isComplete: Bool
//    var isConfirmed: Bool
//    var isActive: Bool
//    var credit: Double
//}
//
//struct birthdate {
//    var id: Int
//    var month: Int
//    var day: Int
//    var year: Int
//}

//func dictionary(data: Any) -> [String:Any] {
//    var dict = [String:Any]()
//    let otherSelf = Mirror(reflecting: data)
//    for child in otherSelf.children {
//        if let key = child.label {
//            dict[key] = child.value
//        }
//    }
//    return dict
//}


//Take an object and preps to be sent as JSON
func convert(list: [Any]) -> [[String:Any]] {
    var dict = [String:Any]()
    var data = [[String:Any]]()
    for obj in list {
        let otherSelf = Mirror(reflecting: obj)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        data.append(dict)
    }
    return data
}
