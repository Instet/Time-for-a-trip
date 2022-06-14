//
//  NetwokManager.swift
//  Time for a trip
//
//  Created by Руслан Магомедов on 10.06.2022.
//

import Foundation

final class NetwokManager {
    

    func fetchData(urlString: String,
                   completion: @escaping (Result<TicketsJSON, Error>) -> Void) {

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error")
                completion(.failure(error))
                return
            }
            guard let data = data else { return }

            do {
                let tickets = try JSONDecoder().decode(TicketsJSON.self, from: data)
                completion(.success(tickets))

            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                completion(.failure(jsonError))
            }

        }.resume()
    }



    func sortByPrice() {
        // here is some code
    }

    func sortedByTime() {
        // here is some code

    }


}
