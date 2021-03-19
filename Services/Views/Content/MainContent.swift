//
//  Content.swift
//  Services
//
//  Created by Camryn on 3/19/21.
//

import SwiftUI

struct MainContent: View {
    var body: some View {
        TabView {
            ServiceListView()
                .tabItem {
                    Image(systemName: "star")
                    Text("One")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Two")
                }
            
            OrderView()
                .tabItem {
                    Image(systemName: "star")
                    Text("One")
                }
            
            AccountView()
                .addPartialSheet()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Two")
                }
        }
    }
}

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        MainContent()
    }
}
