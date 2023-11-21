//
//  Travel.swift
//  TravelJournal
//
//  Created by Raphael Truong on 20/11/2023.
//

import SwiftUI

struct TravelItem: Identifiable {
    let id = UUID()
    var imageUrl: String
    var name: String
    var date: Date
    var price: Double
    var position: String
}
