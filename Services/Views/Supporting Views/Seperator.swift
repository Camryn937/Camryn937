//
//  Seperator.swift
//  Services
//
//  Created by Camryn on 3/18/21.
//

import SwiftUI

struct Seperator: View {
    var body: some View {
        Rectangle()
            .fill(Color("Accent-Color"))
            .frame(height: 8, alignment: .top)
            .overlay(
                Rectangle().stroke(Color("Shadow"), lineWidth: 2))
    }
}

struct  SeperatorWrapper_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Seperator()
        }
    }
}
