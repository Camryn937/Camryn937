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
//  CacheManager.swift
//  network
//
//  Created by Camryn Crowder on 1/1/21.
//

import Foundation

final class CacheController {
    
    private init(){}
    
    static let shared = CacheController()
    
    func clearURLrequests(_ url:URLRequest){
        NetworkController.shared.sessionManager.sessionConfiguration.urlCache?.cachedResponse(for: url)
     }
    
    func clearURLSince(_ date:Date){
        NetworkController.shared.sessionManager.sessionConfiguration.urlCache?.removeCachedResponses(since: date)
     }
    
    func clearURLSession(task: URLSessionDataTask){
        NetworkController.shared.sessionManager.sessionConfiguration.urlCache?.removeCachedResponse(for: task)
     }
    
    func clearCache(){
        NetworkController.shared.sessionManager.sessionConfiguration.urlCache?.removeAllCachedResponses()
    }
    
}

//Control which content is cached from server response
