//
//  ContentView.swift
//  TravelJournal
//
//  Created by Raphael Truong on 20/11/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var travelData = TravelData()

    var body: some View {
        TabView {
            AddTravelView(travelData: travelData)
                .tabItem {
                    Label("Ajouter", systemImage: "plus.circle")
                }

            TravelLink(travelData: travelData)
                .tabItem {
                    Label("Voyages", systemImage: "airplane.circle.fill")
                }
            
        }
    }
}


#Preview {
    ContentView()
}
