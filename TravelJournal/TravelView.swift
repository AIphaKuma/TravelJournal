//
//  TravelView.swift
//  TravelJournal
//
//  Created by Raphael Truong on 20/11/2023.
//
import SwiftUI

struct TravelView: View {
    @Binding var travelItems: [TravelItem]

    var body: some View {
        List(travelItems) { item in
            VStack(alignment: .leading) {
                if let url = URL(string: item.imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 200) // Réglez la hauteur selon vos besoins
                }

                Text(item.name)
                    .font(.headline)

                Text("Date: \(item.date, format: .dateTime)")
                    .font(.subheadline)

                Text("Budget: \(item.price, format: .currency(code: "EUR"))")
                    .font(.subheadline)

                Text("Localisation: \(item.position)")
                    .font(.subheadline)
            }
        }
        .navigationTitle("Voyages")
    }
}



