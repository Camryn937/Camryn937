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

//Generates the checkboxes for each choice


//IDEA Maybe create a state of can be chaecked and can be unchecked
struct ChoiceSection: View {
    
    //order object gets passed to notify view to display as checked
    @ObservedObject var order: Order
    let choices: [OptionsList.Options]
    
    //passes the checked item id back to parent
    let callback: (Int)->()
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(choices, id: \.self) { choice in
                Button(action: {
                    callback(choice.id)
                } ) {
                    Group {
                        CheckboxLabel(order: order, choice: choice)
                    }
                }
                if choice != choices.last {
                    Divider()
                        .padding(.leading)
                }
            }
        }
    }
}

struct CheckboxLabel: View {
    @ObservedObject var order: Order
    let choice: OptionsList.Options
    
    var body: some View {
        HStack {
            
            //Checkbox Field
            Image(systemName: order.selectedItems.contains(choice) ? "checkmark.square.fill" : "square")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor( order.selectedItems.contains(choice) ? .blue : Color("Text"))
            
            
            //choice label
            Text("\(choice.name)")
                .foregroundColor(order.selectedItems.contains(choice) ? .blue : Color("Text"))
                .multilineTextAlignment(.leading)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 35, maxHeight: 35, alignment: .leading)
                .font(.system(size: 16.0, weight: .regular, design: .rounded))

            Spacer()
            
            //Price
            Text("$\(choice.price, specifier: "%.2f")")
                .foregroundColor(order.selectedItems.contains(choice) ? .blue : Color("Text"))
                .font(.system(size: 16.0, weight: .regular, design: .rounded))
        }
        .padding(.horizontal)
    }
}

#if DEBUG
struct ItemViewCardWrapperView: View {
    var order = Order()
    @State var count = 1
    @State var incID = 1
    @State var isShown = true
    let some = true
    @State var choicesChecked = 0

    
    var body: some View {
        ChoiceSection(order: order, choices: [Services.OptionsList.Options(id: 1, name: "Yes", has_options: false, amount: Int(8.00), price: 8.00)], callback: tester)
    }
    func tester(_: Int) {
        print("hello")
    }
}

struct ItemViewCardWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        ItemViewCardWrapperView()
            .previewLayout(.sizeThatFits)
    }
}
#endif

