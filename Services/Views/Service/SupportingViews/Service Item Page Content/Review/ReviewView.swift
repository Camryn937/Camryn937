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
import SwiftUI
import Alamofire


struct ReviewView: View {
    @State var reviews: ReviewObject?
    @State var rating = 0
    var none = "n/a"
    var hasFeatured = true
    @State var canReview = true
    @State var loaded = false
    @State var input = ""
    @State var reviewSent = false
    @State var canScroll = true
    
    var body: some View {
        if loaded == true {
            
            if reviews?.reviews.count == 0 {
                Text("No reviews")
            }
            else {
                VStack(alignment: .center, spacing: 0.0) {
                    if hasFeatured {
                        FeaturedCard(width: 300)
                        Divider()
                    }
                    Group {
                        Text("Review Summary")
                            .font(.system(size: 22.0, weight: .regular, design: .rounded))
                    }
                    .padding(.top, 20.0)
                    .padding(.leading)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    //Review Summary
                    ReviewSummary(reviews: $reviews)
                    
                    //Leave Review Section
                    if canReview {
                        LeaveReivewSection(input: $input, rating: $rating, reviewSent: $reviewSent, canReview: $canReview)
                    }
                    //After Review
                    if reviewSent { ThanksView() }
                    
                    //Loop over reviews
                    ForEach(reviews!.reviews) { review in
                        if review.description != "" {
                            ReviewSection(description: review.description, date: review.added, rating: review.rating)
                        }
                    }
                    
                    Group {
                        NavigationLink(destination: AllReviews()) {
                            HStack {
                                Text("See More")
                                    .padding(.vertical)
                                    .font(.system(size: 16.0, weight: .regular, design: .rounded))
                                    .padding(.top, 15.0)
                            }
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
                .background(Color("Primary"))
            }
        }
        else {
            VStack {
                Text("Loading...")
                    .padding(.top, 100.0)
                    .overlay(
                            AnimationCircleStrokeSpin(size: 30)
                                .padding(.all)
                                .onAppear(perform: loadData))
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .top)
        }
    }
}
#if DEBUG
struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}

#endif

//Stars for avg view & User reviews
struct StarView: View {
    var count: Int
    var body: some View {
        ForEach(1..<6) { star in
            if star <= count {
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14, alignment: .center)
            }
            else {
                Image(systemName: "star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14, alignment: .center)
            }
        }
    }
}

//User review stars for leaving reviews
struct StarReview: View {
    var imageName: String
    var number: Int
    @Binding var rating: Int
    
    var body: some View {
        Group {
            Image(systemName: self.imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(self.rating >= number ? Color("Star") : Color(red: 0.507, green: 0.526, blue: 0.547))
        }.onTapGesture {
            let impactMed = UIImpactFeedbackGenerator(style: .medium)
            impactMed.impactOccurred()
            self.rating = self.number
        }
    }
}

struct FeaturedCard: View {
    var width: CGFloat
    var body: some View {
        HStack {
            Text("Hello")
                .font(.system(size: 16.0, weight: .regular, design: .rounded))
                .frame(width: width, height: 150)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color(red: 0.863, green: 0.863, blue: 0.863), radius: 2, x: 3, y: 3)
                .shadow(color: Color(red: 0.944, green: 0.949, blue: 0.958), radius: 2, x: -3, y: -3)
        }
        .padding(.vertical)
    }
}


extension ReviewView {
    func loadData() {
        NetworkController.shared.loadData(from: "http://192.168.1.75:8000/service/17/reviews/", for: ReviewObject.self, using: .get) { data in
            switch data {
            case .success(let data):
                reviews = data
                loaded = true
                print(data)
                
            default:
                print("failure xx")
            }
        }
    }
    func uploadReview() {
        //        let data = convert(list: order.selectedItems)
        //        let parameters: Parameters = ["item": serviceItem.id, "choices": data]
        //        if user.auth == nil {
        //            user.authLogin()
        //        }
        //        AF.request("http://172.16.0.3:8000/service/cart/", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: user.getHeader())
        //            .responseJSON { response in
        //                //Need to program retry after failure
        //                switch response.result {
        //                case .success( _):
        //                    do {
        //                        print(response)
        //                        self.isShown = false
        //                    }
        //                case .failure(let error):
        //                    print(error)
        //                }
        //            }
    }
}

struct ReviewSection: View {
    let description: String
    let date: String
    let rating: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            HStack {
                //Star review items
                StarView(count: rating)
                Text(date)
                    .font(.system(size: 12.0, weight: .regular, design: .rounded))
                    
                    .foregroundColor(Color.gray)
            }.padding(.vertical, 8.0)
            .foregroundColor(Color(red: 0.978, green: 0.731, blue: 0.034))
            //Add see more option
            Text(description)
                .font(.system(size: 16.0, weight: .medium, design: .rounded))
                
                .foregroundColor(Color("Text"))
                .lineLimit(4)
        }.padding(.all)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
}

struct LeaveReivewSection: View {
    @Binding var input: String
    @Binding var rating: Int
    @Binding var reviewSent: Bool
    @Binding var canReview: Bool
    @State var displacement = CGFloat(0)
    
    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Text("Rate and Review")
                .font(.system(size: 16.0, weight: .medium, design: .rounded))
                
                .foregroundColor(Color("Default-Text"))
            Text("Share your experince to help others")
                .foregroundColor(Color("Default-Text"))
                .font(.system(size: 14.0, weight: .medium, design: .rounded))
            
            HStack(spacing: 10.0) {
                Spacer()
                ForEach(1..<6) { rating in
                    rating > self.rating ? StarReview(imageName: "star", number: rating, rating: self.$rating) : StarReview(imageName: "star.fill", number: rating, rating: self.$rating)
                }
                Spacer()
            }.frame(height: 100, alignment: .center)
            Divider()
            if self.rating > 0 {
                //Show text input field
                ContentTextView(text: $input, placeholderText: "Share your experience", width: 350)
                    .font(.system(size: 16.0, weight: .regular, design: .rounded))
                    .padding(.top)
                Button(action: {
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                    withAnimation(.easeOut, {
                        self.reviewSent = true
                        self.canReview = false
                    })
                }) {
                    Text("Submit")
                        .foregroundColor(.white)
                        .font(.system(size: 16.0, weight: .regular, design: .rounded))
                        .padding()
                        .frame(width: 300, height: 45, alignment: .center)
                        .background(Color.green)
                        .cornerRadius(40)
                }
                .padding(.vertical)
            }
        }
        .padding(.top)
    }
}

struct ReviewSummary: View {
    @Binding var reviews: ReviewObject?
    var body: some View {
        HStack(alignment: .top) {
            VStack(spacing: 5.0) {
                ForEach(0..<reviews!.ratings.count, id: \.self) { i in
                    HStack {
                        Text("\(reviews!.ratings[i].rating)")
                            .font(.system(size: 16.0, weight: .regular, design: .rounded))
                        
                        BarView(value: CGFloat(Double(reviews!.ratings[i].count * 150) / reviews!.average))
                    }
                }
            }.frame(width: 150)
            .foregroundColor(Color("Default-Text"))
            .padding([.top, .leading, .bottom])
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0.0) {
                //Average rating
                let avg = String(format: "%.2f", reviews!.average as CVarArg)
                let stars = Int(reviews!.average.rounded())
                Text("\(avg)")
                    .font(.system(size: 60.0, weight: .medium, design: .rounded))
                    
                    .foregroundColor(Color("Default-Text"))
                
                HStack {
                    ForEach(0..<5) { star in
                        star < stars ? Image(systemName: "star.fill") : Image(systemName: "star")
                    }
                }.foregroundColor(Color("Star"))
                Text("\(reviews!.total) reviews")
                    .font(.system(size: 16.0, weight: .regular, design: .rounded))
                    
                    .foregroundColor(Color.gray)
                    .padding(.top, 10.0)
            }
        }.padding(.horizontal)
        Divider()
    }
}

