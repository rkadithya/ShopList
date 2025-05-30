//
//  NetworkManager.swift
//  ShopList
//
//  Created by RK Adithya on 29/05/25.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    private let urlString = "https://run.mocky.io/v3/0a32f55e-2422-49c0-9c72-c9d7b9e736b1"

    func fetchArticles() -> AnyPublisher<[Article], Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ArticleResponse.self, decoder: JSONDecoder())
            .map(\.articles)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
