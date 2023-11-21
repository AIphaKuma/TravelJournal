//
//  ContentView.swift
//  TravelJournal
//
//  Created by Raphael Truong on 20/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var urlString: String = ""
    @State private var name: String = ""
    @State private var date = Date()
    @State private var price: Double = 0.0
    @State private var position: String = ""
    @State private var travelItems: [TravelItem] = []


    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Image")) {
                    TextField("Image URL", text: $urlString)
                    if let url = URL(string: urlString), urlString != "" {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode:.fit)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }

                Section(header: Text("Details")) {
                    TextField("Nom du voyage", text: $name)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    HStack {
                        Text("€")
                            .foregroundColor(.gray)
                        TextField("Budget", value: $price, format: .number)
                            .keyboardType(.decimalPad)
                    }
                    TextField("Localisation", text: $position)

                }
                
                Button("Ajouter Voyage") {
                    let newItem = TravelItem(imageUrl: urlString, name: name, date: date, price: price, position: position)
                    travelItems.append(newItem)
                    // Réinitialiser les champs si nécessaire
                    urlString = ""
                    name = ""
                    date = Date()
                    price = 0.0
                    position = ""
                }
                
                Section {
                    NavigationLink("Voir les Voyages", destination: TravelView(travelItems: $travelItems))
                }

            }
            .navigationTitle("Ajouter un Trip")
        }
    }
}


#Preview {
    ContentView()
}
