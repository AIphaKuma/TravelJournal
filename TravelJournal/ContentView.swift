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
            TravelLink(travelData: travelData)
                .tabItem {
                    Label("Mes Voyages", systemImage: "airplane.circle.fill")
                }
            
            AddTravelView(travelData: travelData)
                .tabItem {
                    Label("Ajouter", systemImage: "plus.circle")
                }
        }
        .tint(.pink)
    }
}


#Preview {
    ContentView()
}
