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

//Global service object
class Order: ObservableObject {
    @Published var selectedItems = [OrderOption.Choice]()
    @Published var total = 0.0
    @Published var qty = 1.00
    @Published var message = ""
    
    
    @Published var isUploaded = false
    
    
    //clear cart
    func clear() {
        selectedItems = [OrderOption.Choice]()
        total = 0.0
        qty = 0.0
    }

    //update order total
    func update() {
        total = 0.0
        for item in selectedItems {
            total += item.price
        }
        self.total *= qty
    }

    func cancel() {
        selectedItems.removeAll()
    }
    
    func uploadOrder() {
        let item = OrderItem(item: selectedItems, quantity: Int(qty), total: total, instructions: message)
        var parameters: Parameters = [:]

        do {
            let jsonData = try JSONEncoder().encode(item)
            let jsonString = String(data: jsonData, encoding: .utf8)!

            parameters = ["data": jsonString]

        } catch { print(error) }

        NetworkController.shared.loadData(from: "http://192.168.1.75:8000/service/cart/",
                                          for: OrderOption.Choice.self, using: .post, parameters: parameters) { response in
            switch response {
            case .success(let data):
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                    print(data)
                }
                let isUploaded = true
                return isUploaded

            case .failure(let error):
                let isUploaded = false
                print("Error - \(error)")
                print(parameters)
                return isUploaded
            }
        }
    }
}

struct OrderItem: Codable {
    let item: [OrderOption.Choice]
    let quantity: Int
    let total: Double
    let instructions: String?
}

struct SelectedItems: Codable {
    var choices: [OrderOption.Choice]
//    var userMessage: String?
//    var photos: [UIImage]?
}


struct UserCartItems: Codable, Identifiable, Equatable {
    let id: Int
    let locationId: Int
    let service: ServiceData.ServiceItem?
    let choices: [OrderOption.Choice]
    let optionList: [OrderOption]?
}

//MARK:-ServiceItemSection & ServiceItemChoice
struct ServiceItemData: Codable {
    let serviceItem: ServiceData.ServiceItem
    let orderOption: [OrderOption]
    let quantity: Int?
    let message: String?
}

// ServiceList.swift
//[McDonalds, Chick-fil-a, ETC....]
struct ServiceList: Codable {
    let services: [Service]
    
    enum CodingKeys: String, CodingKey {
        case services = "services"
    }
}

//MARK:-Service
struct Service: Codable, Hashable {
    let id: Int
    let name: String
    let imageURL: String
    let location: [Location]?
        
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case imageURL = "header_image_url"
        case location = "locations"
    }
}


//MARK:-ServiceItem
struct ServiceData: Codable {
    let service: Service
    let serviceItems: [ServiceItem]
    
    struct ServiceItem: Codable, Hashable {
        let id: Int
        let name: String
        let imageURL: String?
        let description: String
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "service_name"
            case imageURL = "image_url"
            case description = "description"
        }
    }
}

//Each card section
struct OrderOption: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let is_required: Bool
    let choices: [Choice]
    let min_options: Int
    let max_options: Int
    
    //What is selected from the list of options
    struct Choice: Codable, Identifiable, Hashable{
        let id: Int
        let answer: String
        var has_options: Bool
        let price: Double
    }
    
//    enum CodingKeys: String, CodingKey {
//    }
}

struct Location: Codable, Hashable {
    var id: Int
}

struct ReviewObject: Codable {
    let total: Int
    let average: Double
    let ratings: [Rating]
    let reviews: [Review]
    
    struct Rating: Codable {
        let rating: Int
        let count: Int
    }
}

struct Review: Codable, Identifiable, Hashable {
    let id: Int
    let rating: Int
    let description: String
    let added: String
    let service: Int
}

struct ReviewList: Codable, Hashable{
    let reviews: [Review]
}

struct Cart: Codable {
    let cart: [CartItem]
}
struct CartItem: Codable, Hashable {
    let id: Int
    let item: Int
    let service: ServiceLocation
    let serviceItem: ServiceData.ServiceItem
    let choice: [OrderOption.Choice]
}

struct ServiceLocation: Codable, Hashable {
    var id: Int
    var service_range: Int
    var is_active: Bool
    var is_available: Bool
    var is_open: Bool
    var is_closing_soon: Bool
    var offers_delivery: Bool
    var offers_pickup: Bool
    var is_subscribable: Bool
    var service: Int
}
