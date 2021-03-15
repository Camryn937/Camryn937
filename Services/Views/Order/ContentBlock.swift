//
//  ContentBlock.swift
//  Services
//
//  Created by Camryn Crowder on 1/5/21.
//  Copyright © 2021 Capsule. All rights reserved.
//

import SwiftUI

struct ContentBlock: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Earn with Google Pay")
                    .font(.system(size: 24.0, weight: .regular, design: .rounded))

                    .padding(.bottom)
                Spacer()
            }
            Text("Hello, World!")
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 14).stroke(Color.gray)
                )
        }
        .padding(.horizontal)
    }
}

struct ContentBlock_Previews: PreviewProvider {
    static var previews: some View {
        ContentBlock()
    }
}
