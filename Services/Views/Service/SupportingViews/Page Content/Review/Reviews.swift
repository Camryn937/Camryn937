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
//  Created by: Camryn Crowder on 3/11/21
//  Copyright © 2021 Capsule. All rights reserved.
//

import SwiftUI


struct AllReviews: View {
    @State var reviews: ReviewList?
    @State var loaded = false
    @State var allReviews = false
    let id = 18
    
    var body: some View {
        if loaded {
            ScrollView {
                VStack {
                    
                    Picker(selection: $allReviews, label: Text("Selection")) {
                        Text("Local").tag(true)
                        Text("All").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    VStack {
                        ForEach(0..<reviews!.reviews.count){ index in
                            NavigationLink(destination: DetailReview()) {
                                if allReviews {
                                    if reviews!.reviews[index].service == id {
                                        Reviews(review: reviews!.reviews[index])
                                    }
                                }
                                else {
                                    Reviews(review: reviews!.reviews[index])
                                }
                            }
                        }
                    }
                }
            }
        }
        else {
            Text("Loading...")
                .onAppear(perform: { loadData() })
        }
    }
}

extension AllReviews {
    func loadData() {
        NetworkController.shared.loadData(from: "http://192.168.1.75:8000/service/\(id)/allreviews/", for: ReviewList.self, using: .get) { data in
            switch data {
            case .success(let data):
                reviews = data
                loaded = true
                return loaded
                
            default:
                print("failure xx")
                return false
            }
        }
    }
}

struct AllReviews_Previews: PreviewProvider {
    static var previews: some View {
        AllReviews()
    }
}


struct Reviews: View {
    let review: Review
    
    var body: some View {
        VStack {
            if review.description != "" {
                ReviewSection(description: review.description, date: review.added, rating: review.rating)
            }
        }
    }
}
