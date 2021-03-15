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
//
//  Authentication.swift
//  network
//
//  Created by Camryn Crowder on 1/1/21.
//

import Foundation
import Alamofire


//MARK: - AUTH
final class ApiAuthentication {
    
    //MARK: - OAuthCredential
    struct OAuthCredential: AuthenticationCredential {
        let accessToken: String
        let refreshToken: String
//        let userID: String
        let expiration: Date
        
        // Require refresh if within 10 minutes of expiration
        var requiresRefresh: Bool { Date(timeIntervalSinceNow: 60 * 10) > expiration }
    }
    
    //MARK: - OAuthAuthenticator
    class OAuthAuthenticator: Authenticator {
        func apply(_ credential: OAuthCredential, to urlRequest: inout URLRequest) { urlRequest.headers.add(.authorization(bearerToken: credential.accessToken)) }
        
        func refresh(_ credential: OAuthCredential, for session: Session, completion: @escaping (Result<OAuthCredential, Error>) -> Void) {
            // Refresh the credential using the refresh token...then call completion with the new credential.
            //
            // The new credential will automatically be stored within the `AuthenticationInterceptor`. Future requests will
            // be authenticated using the `apply(_:to:)` method using the new credential.
        }
        
        func didRequest(_ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: Error) -> Bool {
            // If authentication server CANNOT invalidate credentials, return `false`
            return false
            
            // If authentication server CAN invalidate credentials, then inspect the response matching against what the
            // authentication server returns as an authentication failure. This is generally a 401 along with a custom
            // header value.
            // return response.statusCode == 401
        }
        
        func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: OAuthCredential) -> Bool {
            // If authentication server CANNOT invalidate credentials, return `true`
            return true
            
            // If authentication server CAN invalidate credentials, then compare the "Authorization" header value in the
            // `URLRequest` against the Bearer token generated with the access token of the `Credential`.
            // let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
            // return urlRequest.headers["Authorization"] == bearerToken
            
        }
    }
}



