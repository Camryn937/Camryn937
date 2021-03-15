///// Copyright (c) 2020 Capsule LLC
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
//  Services
//
//  Created by: Camryn Crowder on 1/8/21 xz//  Copyright © 2021 Capsule. All rights reserved.
//

import Foundation

struct UserAccount: Codable, Identifiable {
    let id: Int
    var address : [AddressObject]?
    var username: String
    var firstName: String
    var lastName: String
    var email: String
    var isActive: Bool
    let profile: Profile?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case address = "address"
        case username = "username"
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case isActive = "is_active"
        case profile = "profile"
    }
}

struct AddressObject: Codable, Identifiable {
    let id: Int
    var isDefault: Bool
    var address: UserAddress
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case isDefault = "is_default"
        case address = "address"
    }
}
struct UserAddress: Codable, Identifiable {
    var id: Int
    var address1: String
    var address2: String?
    var country: String
    var area: Area
    var geo: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case address1 = "address1"
        case address2 = "address2"
        case country = "country"
        case area = "area"
        case geo = "geo"
    }
}

struct Area: Codable, Identifiable {
    var id: Int
    var zipCode: String
    var city: String
    var state: String
    var timezone: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case zipCode = "zip_code"
        case city = "city"
        case state = "state"
        case timezone = "timezone"
    }
}

struct Profile: Codable, Identifiable {
    let id: Int
    var balance: Int
    var phone: String?
    var birthdate: String?
    var isConfirmed: Bool
    var isCompleted: Bool
    var emailVerified: Bool
    var phoneVerified: Bool
    var customer: String?
    var hasTexts: Bool
    var hasPromo: Bool
    var hasNotifications: Bool
    var credit: Int
    var image: String?
    var rentalStatus: Bool
    var verifiedId: Bool
    let user: Int

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case balance = "balance"
        case phone = "phone"
        case birthdate = "birthdate"
        case isConfirmed = "is_confirmed"
        case isCompleted = "is_complete"
        case emailVerified = "email_is_verified"
        case phoneVerified = "phone_is_verified"
        case customer = "customer"
        case hasTexts = "gets_texts"
        case hasNotifications = "gets_notifications"
        case hasPromo = "gets_promotions"
        case credit = "account_credits"
        case image = "image"
        case rentalStatus = "rental_status"
        case verifiedId = "verified_id"
        case user = "user"
    }
}

struct AuthTokens: Codable {
    var refresh: String
    var access: String
    var created = Date(timeIntervalSinceNow: 60 * 60)
}

struct PaymentMethods: Codable, Identifiable {
    let id: Int
    let type: String
    let brand: String
    var expM: String
    var expY: String
    var last4: String
    let name: String
    var isDefault: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "payment_type"
        case brand = "brand"
        case expM = "exp_month"
        case expY = "exp_year"
        case last4 = "last4"
        case name = "name"
        case isDefault = "is_default"
    }
}
