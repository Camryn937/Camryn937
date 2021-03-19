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
	@Published var selectedService = [ServiceData.ServiceItem]()
    @Published var selectedItems = [OrderOption.Choice]()
    @Published var total = 0.0
    @Published var qty = 1.00
    @Published var message = ""
    
    
    @Published var isUploaded = false
    
    
    //clear cart
    func clear() {
		selectedService = [ServiceData.ServiceItem]()
        selectedItems = [OrderOption.Choice]()
        total = 0.0
        qty = 0.0
    }

    //update order total
    func update() {
        total = 0.0
        
        if selectedService.count == 1 {
            self.total += selectedService[0].price
        }
        for item in selectedItems {
            total += item.price
        }
        self.total *= qty
    }

    func cancel() {
        selectedItems.removeAll()
		selectedService.removeAll()
    }
    
    func uploadOrder(asUpdate: Bool) {
        var parameters: Parameters = [:]
        
        let item = CartItem(id: 2, serviceItem: selectedService.first! , choices: selectedItems, quantity: Int(qty), instructions: message)

        do {
            let jsonData = try JSONEncoder().encode(item)
            let jsonString = String(data: jsonData, encoding: .utf8)!

            parameters = ["data": jsonString]

        } catch { print(error) }
        
        //If order is being updated then handle the request this way
        if asUpdate {
            
        }
        
        else {
            
        }
        
        NetworkController.shared.loadData(from: "http://192.168.1.75:8000/service/cart/",
                                          for: ApiRespose.self, using: .put, parameters: parameters) { response in
            switch response {
            case .success(let data):
                print(data)
                self.isUploaded = true
            case .failure(let error):
                print("Error - \(error)")
                self.isUploaded = true
            }
        }
    }
}

//MARK:-CartItem
struct CartItem: Codable, Identifiable, Hashable {
	let id: Int
	let serviceItem: ServiceData.ServiceItem
    let choices: [OrderOption.Choice]
    let quantity: Int
	let instructions: String?
//  let total: Double
//	let is_subscribed: Bool
//	let frequency: String
	
	
	enum CodingKeys: String, CodingKey {
		case id = "id"
		case serviceItem = "service"
		case choices = "choice"
		case quantity = "quantity"
		case instructions = "special_instructions"
	}
}

//MARK:-Cart
struct Cart: Codable, Identifiable, Hashable {
	let id: Int
	let items_in_cart: [CartItem]
	let message: String
}

//MARK:-ServiceItemSection & SectionChoice
struct ServiceItemData: Codable {
    let serviceItem: ServiceData.ServiceItem
    let orderOption: [OrderOption]
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
		let price: Double
		
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "service_name"
            case imageURL = "image_url"
            case description = "description"
			case price = "price"
        }
    }
}

//MARK:-ServiceItemSectionField
struct OrderOption: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let is_required: Bool
    let choices: [Choice]
    let min_options: Int
    let max_options: Int
    
	//MARK:-SectionChoice
    struct Choice: Codable, Identifiable, Hashable {
        let id: Int
        let answer: String
        var has_options: Bool
        let price: Double
    }
}

//MARK:-ServiceLocation
struct Location: Codable, Hashable {
    var id: Int
}

//MARK:-Review
struct ReviewObject: Codable {
    let total: Int
    let average: Double
    let ratings: [Rating]
    let reviews: [Review]
    
    struct Rating: Codable {
        let rating: Int
        let count: Int
    }
	
	struct Review: Codable, Identifiable, Hashable {
		let id: Int
		let rating: Int
		let description: String
		let added: String
		let service: Int
	}

}


////MARK:-CartItem
//struct CartItem: Codable, Hashable {
//    let id: Int
//    let item: Int
//    let service: ServiceLocation
//    let serviceItem: ServiceData.ServiceItem
//    let choice: [OrderOption.Choice]
//}

//MARK:-ServiceLocation
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
