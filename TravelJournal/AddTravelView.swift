//
//  AddTravelView.swift
//  TravelJournal
//
//  Created by Raphael Truong on 21/11/2023.
//

import SwiftUI

struct AddTravelView : View {
    @State private var urlString: String = ""
    @State private var name: String = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var price: Double = 0.0
    @State private var position: String = ""
    @ObservedObject var travelData: TravelData



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
                    DatePicker("Date d'arrivée", selection: $startDate, displayedComponents: .date)
                        .environment(\.locale, Locale(identifier: "fr_FR"))
                    DatePicker("Date de retour", selection: $endDate, displayedComponents: .date)
                        .environment(\.locale, Locale(identifier: "fr_FR"))
                    HStack {
                        Text("€")
                            .foregroundColor(.gray)
                        TextField("Budget", value: $price, format: .number)
                            .keyboardType(.decimalPad)
                    }
                    TextField("Localisation", text: $position)

                }
                
                Button("Ajouter Voyage") {
                    let newItem = TravelItem(imageUrl: urlString, name: name, startDate: startDate, endDate: endDate, price: price, position: position)
                    travelData.items.append(newItem)
                    urlString = ""
                    name = ""
                    startDate = Date()
                    endDate = Date()
                    price = 0.0
                    position = ""
                }
            }
            .navigationTitle("Ajouter un Trip")
        }
    }
}

