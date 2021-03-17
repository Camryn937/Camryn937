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

struct ServiceItemCard: View {
    @Binding var incompletedID: Int //Return to parent to scroll
    @Binding var requiredCount: Int //Number of ItemCard elements that requires at least 1 item
    @ObservedObject var order: Order //Add order items to cart from child view
    let serviceItem: [OrderOption.Choice] //Iterate over options in child=
    let callback: ()->() //function to call from the parent view
    @State var completed = false //Checks card status Required done or not
    @State var optionsChecked = 0
    @State var lastChecked = [OrderOption.Choice]()
    let option: OrderOption
    @Binding var locked: Bool
    
    var body: some View {
        //Generate card Title
        VStack {
            HStack(alignment: .top) {
                
                VStack(alignment: .leading) {
                    //Selection Name
                    Text("\(option.name)")
                        .font(.system(size: 16.0, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("Text"))
                        .lineLimit(nil)
                        .padding(.top)
                    if option.min_options != 0 {
                        Text(completed ? "Select up to \(option.max_options)" : "Select at least \(option.min_options)")
                            .font(.system(size: 14.0, weight: .medium, design: .rounded))
                            .padding(.all, 4.0)
                            .cornerRadius(4)
                    }
                }
                
                Spacer()
                
                VStack {
                    Text(option.min_options > 0 ? "Required" : "Optional")
                        .font(.system(size: 14.0, weight: .heavy, design: .rounded))

                        .foregroundColor(option.min_options > 0 ? Color.black : Color("Text"))
                        .padding(.all, 4.0)
                        .background(option.min_options > 0 ? Color.yellow : Color("Primary"))
                        .cornerRadius(4.0)
                                        
                }
                .padding(.top)
            }
            .padding(.horizontal)
            
            //Generates the fields
            ChoiceSection(order: order, choices: serviceItem, callback: evaluate)
        }
        .onAppear( perform: { setup() })
    }
}

#if DEBUG
struct ServiceItemCardWrapper: View {
    @State var requiredCount = 2
    @State var incompleteID = 2
    @State var locked = false
    var data = [Services.OrderOption(id: 1, name: "Include Laundry Bag", is_required: false, choices: [Services.OrderOption.Choice(id: 1, answer: "Yes", has_options: false, price: 5.00)], min_options: 0, max_options: 1), OrderOption(id: 2, name: "What Detergent Should We Use", is_required: true, choices: [Services.OrderOption.Choice(id: 2, answer: "Tide", has_options: false, price: 6.00), Services.OrderOption.Choice(id: 3, answer: "Gain", has_options: false, price: 2.50)], min_options: 1, max_options: 1), Services.OrderOption(id: 3, name: "Please Select A Fabric Softener", is_required: true, choices: [Services.OrderOption.Choice(id: 4, answer: "Snuggle", has_options: false, price: 4.00), Services.OrderOption.Choice(id: 5, answer: "Angel Soft", has_options: false, price: 3.50)], min_options: 1, max_options: 2)]
    var some = "Cam"
    var body: some View {
        VStack {
            ForEach(data, id:\.self) { option in
                ServiceItemCard(incompletedID: $incompleteID, requiredCount: $requiredCount, order: Order(), serviceItem: option.choices, callback: tester, option: option, locked: $locked)
                Seperator()
            }
        }
    }
    func tester() {
        print("hello")
    }
}

struct ServiceItemCard_Previews: PreviewProvider {
    static var previews: some View {
        ServiceItemCardWrapper()
            .previewLayout(.sizeThatFits)
    }
}
#endif


extension ServiceItemCard {
    func evaluate(selectedOption: Int) {
        //Choice searches list of choices by id and is assigned that value
        //e.x. Services.OrderOption.Choice(id: 3, name: "Gain", has_options: false)
        let choice = serviceItem.first(where: { $0.id == selectedOption} )
        
        if optionsChecked < option.min_options { incompletedID = option.id }
        if requiredCount < 0 { requiredCount = 0 }
        
        //switch check when max is checked
        if optionsChecked == option.max_options {
            //if field not required then uncheck
            //If max is checked then swap
            if order.selectedItems.contains(choice!) {
                if optionsChecked > option.min_options || option.min_options == 0 {
                    if !locked {
                        uncheck(choice: choice!)
                    }
                }
            }
            else if lastChecked.count > 0 {
                if !locked {
                    uncheck(choice: lastChecked[0])
                    check(choice: choice!, isReload: false)
                    lastChecked = [choice!]
                }
            }
            else { print("option") }
        }
        else if order.selectedItems.contains(choice!) {
            //evaluate if item can be unchecked
            if optionsChecked <= option.max_options && optionsChecked > option.min_options || option.min_options == 0 || optionsChecked > option.max_options {
                if !locked {
                    uncheck(choice: choice!)
                }
            }
            else if optionsChecked > option.min_options {
                if !locked {
                    uncheck(choice: choice!)
                }
            }
            else {
                print("shake animation")
            }
        }
        //checks field
        else if optionsChecked <= option.min_options {
            if !locked {
                check(choice: choice!, isReload: false)
            }
        }
        process()
    }
    
    func check(choice: OrderOption.Choice, isReload: Bool) {
        if !order.selectedItems.contains(choice) {
            order.selectedItems.append(choice)
            print("checked")
            optionsChecked += 1
            lastChecked = [choice]
            order.update()
        }
    }
    func uncheck(choice: OrderOption.Choice) {
        if let index = order.selectedItems.firstIndex(of: choice) {
            order.selectedItems.remove(at: index)
            optionsChecked -= 1
            order.update()
        }
    }
    
    func process() {
        if optionsChecked >= option.min_options && option.min_options > 0 && !completed {
            requiredCount -= 1
            completed = true
        }
    }
    func setup() {
        //Sets the count of options constraint to the correct ammount
        let output = serviceItem.filter{ order.selectedItems.contains($0) }
        optionsChecked = output.count
        if output.count > 0 {
            lastChecked.removeAll()
            lastChecked.append(output.last!)
        }
        process()
        order.update()
    }
}
