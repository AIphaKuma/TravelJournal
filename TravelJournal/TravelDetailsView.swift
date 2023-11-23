import SwiftUI

struct TravelDetailsView: View {
    var travelItem: TravelItem
    @State private var responseString = "Chargement..."
    @State private var businesses: [YelpBusiness] = []
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)


    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let url = URL(string: travelItem.imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 300)
                }

                Group {
                    HStack {
                        Text("\(travelItem.startDate, format: .dateTime.year().month().day())")
            
                        Text("- \(travelItem.endDate, format: .dateTime.year().month().day())")
                    }
                    .font(.subheadline)

                    Text("Durée: \(travelItem.stayDuration) jours")
                        .font(.subheadline)

                    Text("Position: \(travelItem.position)")
                        .font(.subheadline)

                    Text("Budget: \(travelItem.price, format: .currency(code: "EUR"))")
                        .font(.subheadline)
                }
                Group {
                    Text("SUGGESTIONS")
                            .font(.title)
                            .padding([.bottom, .top], 20)
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(businesses, id: \.name) { business in
                            VStack(alignment: .leading) {
                            AsyncImage(url: URL(string: business.imageUrl)) { image in
                                    image
                                    .resizable()                                
                            } placeholder: {
                                    ProgressView()
                            }
                            .frame(height: 200)

                            Spacer().frame(height: 10)
                            Text(business.name).font(.headline)
                            Text("Note : \(business.rating, specifier: "%.1f") (\(business.reviewCount))")
                            Text(business.categories.first?.title ?? "Catégorie non disponible")
                            Text(business.location.displayAddress.joined(separator: ", "))
                            }
                        }
                    }
                }
            }
                .padding(.horizontal)
                .onAppear {
                    YelpController().fetchData(forLocation: travelItem.position) { newBusinesses in
                        businesses = newBusinesses
                    }
                }
                
            }
        .navigationTitle(travelItem.name)
        .navigationBarTitleDisplayMode(.inline)
        }
    }


#Preview {
    let startDate = Calendar.current.date(from: DateComponents(year: 2022, month: 12, day: 29)) ?? Date()
    let endDate = Calendar.current.date(from: DateComponents(year: 2023, month: 1, day: 1)) ?? Date()
    return TabView{
        TravelDetailsView(travelItem: TravelItem(imageUrl: "", name: "Voyage", startDate: startDate, endDate: endDate, price: 500, position: "Paris"))
        .tabItem {
            Label("Voyages", systemImage: "airplane.circle.fill")
        }
    }
}
