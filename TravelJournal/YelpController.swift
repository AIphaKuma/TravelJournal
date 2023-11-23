//
//  YelpController.swift
//  TravelJournal
//
//  Created by Raphael Truong on 22/11/2023.
//

import Foundation

struct YelpController {
    func fetchData(forLocation location: String, completion: @escaping ([YelpBusiness]) -> Void) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer yqyVolaqnSiuXJrOPvjffcXABf4sZQMmLn3n2feKwPSqAZL6utb5NSFwVnSpldhm7piCU0ECB9mCvzGfSqjG0sdW7BXt1tliYeVPGM6HQlAlDZ3m44PX-anNKQdeZXYx"
        ]

        if let encodedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: "https://api.yelp.com/v3/businesses/search?location=\(encodedLocation)&sort_by=best_match&limit=5") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Erreur de requête : \(error)")
                    return
                }
                if let data = data {
                    do {
                        print(String(data: data, encoding: .utf8) ?? "Données non lisibles")
                        let jsonResponse = try JSONDecoder().decode(YelpResponse.self, from: data)
                        completion(jsonResponse.businesses)
                        jsonResponse.businesses.forEach { print($0) }
                    } catch {
                        print("Erreur de décodage JSON : \(error)")
                    }
                }
            }
            dataTask.resume()
        }
    }

            struct YelpResponse: Codable {
                let businesses: [YelpBusiness]
            }
    }

