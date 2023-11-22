//
//  YelpController.swift
//  TravelJournal
//
//  Created by Raphael Truong on 22/11/2023.
//

import Foundation

struct YelpController {
    func fetchData(completion: @escaping ([YelpBusiness]) -> Void) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer yqyVolaqnSiuXJrOPvjffcXABf4sZQMmLn3n2feKwPSqAZL6utb5NSFwVnSpldhm7piCU0ECB9mCvzGfSqjG0sdW7BXt1tliYeVPGM6HQlAlDZ3m44PX-anNKQdeZXYx"
        ]

        if let url = URL(string: "https://api.yelp.com/v3/businesses/search?location=Paris&sort_by=best_match&limit=10") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                        if let error = error {
                            print("Erreur : \(error)")
                            return
                        }
                        if let data = data {
                            do {
                                let jsonResponse = try JSONDecoder().decode(YelpResponse.self, from: data)
                                completion(jsonResponse.businesses)
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

