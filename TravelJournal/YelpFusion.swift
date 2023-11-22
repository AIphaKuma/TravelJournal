//
//  YelpFusion.swift
//  TravelJournal
//
//  Created by Raphael Truong on 22/11/2023.
//

import Foundation

struct YelpBusiness: Codable {
    let name: String
    let imageUrl: String
    let reviewCount: Int
    let categories: [Category]
    let rating: Double
    let location: Location

    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "image_url"
        case reviewCount = "review_count"
        case categories
        case rating
        case location
    }

    struct Category: Codable {
        let title: String
    }

    struct Location: Codable {
        let displayAddress: [String]

        enum CodingKeys: String, CodingKey {
            case displayAddress = "display_address"
        }
    }
}
