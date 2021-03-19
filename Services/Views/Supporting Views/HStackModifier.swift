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
//  HStackModifier.swift
//  Services
//
//  Created by Camryn Crowder on 10/29/20.
//  Copyright © 2020 Capsule. All rights reserved.
//

//import SwiftUI

//struct HStackModifier: View {
//    var colors: [Color] = [.blue, .green, .red, .orange]
//    
//    var body: some View {
//        HStack(alignment: .center, spacing: 30) {
//            ForEach(0..<colors.count) { i in
//                 colors[i]
//                     .frame(width: 250, height: 400, alignment: .center)
//                     .cornerRadius(10)
//            }
//        }.modifier(ScrollingHStackModifier(items: colors.count, itemWidth: 250, itemSpacing: 30))
//    }
//}
//
//struct HStackModifier_Previews: PreviewProvider {
//    static var previews: some View {
//        HStackModifier()
//    }
//}


//struct ScrollingHStackModifier: ViewModifier {
//    
//    @State private var scrollOffset: CGFloat
//    @State private var dragOffset: CGFloat
//    
//    var items: Int
//    var itemWidth: CGFloat
//    var itemSpacing: CGFloat
//    
//    init(items: Int, itemWidth: CGFloat, itemSpacing: CGFloat) {
//        self.items = items
//        self.itemWidth = itemWidth
//        self.itemSpacing = itemSpacing
//        
//        // Calculate Total Content Width
//        let contentWidth: CGFloat = CGFloat(items) * itemWidth + CGFloat(items - 1) * itemSpacing
//        let screenWidth = UIScreen.main.bounds.width
//        
//        // Set Initial Offset to first Item
//        let initialOffset = (contentWidth/2.0) - (screenWidth/2.0) + ((screenWidth - itemWidth) / 2.0)
//        
//        self._scrollOffset = State(initialValue: initialOffset)
//        self._dragOffset = State(initialValue: 0)
//    }
//    
//    func body(content: Content) -> some View {
//        content
//            .offset(x: scrollOffset + dragOffset, y: 0)
//            .gesture(DragGesture()
//                .onChanged({ event in
//                    dragOffset = event.translation.width
//                })
//                .onEnded({ event in
//                    // Scroll to where user dragged
//                    scrollOffset += event.translation.width
//                    dragOffset = 0
//                    
//                    // Now calculate which item to snap to
//                    let contentWidth: CGFloat = CGFloat(items) * itemWidth + CGFloat(items - 1) * itemSpacing
//                    let screenWidth = UIScreen.main.bounds.width
//                    
//                    // Center position of current offset
//                    let center = scrollOffset + (screenWidth / 2.0) + (contentWidth / 2.0)
//                    
//                    // Calculate which item we are closest to using the defined size
//                    var index = (center - (screenWidth / 2.0)) / (itemWidth + itemSpacing)
//                    
//                    // Should we stay at current index or are we closer to the next item...
//                    if index.remainder(dividingBy: 1) > 0.5 {
//                        index += 1
//                    } else {
//                        index = CGFloat(Int(index))
//                    }
//                    
//                    // Protect from scrolling out of bounds
//                    index = min(index, CGFloat(items) - 1)
//                    index = max(index, 0)
//                    
//                    // Set final offset (snapping to item)
//                    let newOffset = index * itemWidth + (index - 1) * itemSpacing - (contentWidth / 2.0) + (screenWidth / 2.0) - ((screenWidth - itemWidth) / 2.0) + itemSpacing
//                    
//                    // Animate snapping
//                    withAnimation {
//                        scrollOffset = newOffset
//                    }
//                    
//                })
//            )
//    }
//}
