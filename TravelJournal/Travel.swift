import SwiftUI

class TravelData: ObservableObject {
    @Published var items: [TravelItem] = []
}

class TravelItem: ObservableObject, Identifiable {
    let id = UUID()
    
    @Published var imageUrl: String
    @Published var name: String
    @Published var startDate: Date
    @Published var endDate: Date
    @Published var price: Double
    @Published var position: String

    var stayDuration: Int {
        Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
    }

    init(imageUrl: String, name: String, startDate: Date, endDate: Date, price: Double, position: String) {
        self.imageUrl = imageUrl
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.price = price
        self.position = position
    }
}
