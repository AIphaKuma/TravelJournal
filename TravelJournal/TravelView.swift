//
//  TravelView.swift
//  TravelJournal
//
//  Created by Raphael Truong on 20/11/2023.
//
import SwiftUI

struct TravelLink: View {
    @ObservedObject var travelData: TravelData

    var body: some View {
        NavigationView {
            List {
                if travelData.items.isEmpty {
                    Text("Aucun voyage n'a été ajouté.")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    
                } else {
                    ForEach(travelData.items, id: \.id) { item in
                        NavigationLink(destination: TravelDetailsView(travelItem: item)) {
                            TravelView(travelItem: item)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("Voyages")
            .listStyle(PlainListStyle())
        
        }
    }

    func deleteItems(at offsets: IndexSet) {
        travelData.items.remove(atOffsets: offsets)
    }
}


struct TravelView: View {
    var travelItem: TravelItem

    var body: some View {
        VStack(alignment: .leading) {
            if let url = URL(string: travelItem.imageUrl) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                .cornerRadius(10) // Ajoutez un rayon de coin pour adoucir les bords
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(travelItem.name)
                    .font(.headline)
                Text("\(travelItem.startDate, format: .dateTime.year().month().day()) - \(travelItem.endDate, format: .dateTime.year().month().day())")
                    .font(.subheadline)
                Text(travelItem.position)
                    .font(.subheadline)
            }
            .padding([.leading, .bottom, .trailing])
        }
        .background(Color.white) // Fond blanc pour la carte
        .cornerRadius(10) // Coins arrondis pour la carte
        .shadow(radius: 5) // Ombre pour un effet de surélévation
    }
}

#Preview {
    let startDate = Calendar.current.date(from: DateComponents(year: 2022, month: 12, day: 29)) ?? Date()
    let endDate = Calendar.current.date(from: DateComponents(year: 2023, month: 1, day: 1)) ?? Date()
    let travelData = TravelData()
            travelData.items.append(TravelItem(imageUrl: "https://images.unsplash.com/photo-1562832625-795d57deb5ef?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHZveWFnZXxlbnwwfHwwfHx8MA%3D%3D", name: "Voyage 1", startDate: startDate, endDate: endDate, price: 1000, position: "New-York"))
    return TabView {
                TravelLink(travelData: travelData)
                    .tabItem {
                        Label("Voyages", systemImage: "airplane.circle.fill")
                    }
            }
    }


