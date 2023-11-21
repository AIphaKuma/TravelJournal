//
//  ContentView.swift
//  TravelJournal
//
//  Created by Raphael Truong on 20/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var travelItems: [TravelItem] = []

    var body: some View {
        TabView {
            AddTravelView(travelItems: $travelItems)
                .tabItem {
                    Label("Ajouter", systemImage: "plus.circle")
                }

            TravelLink(travelItems: $travelItems)
                .tabItem {
                    Label("Voyages", systemImage: "airplane.circle.fill")
                }
            
        }
    }
}


#Preview {
    ContentView()
}
