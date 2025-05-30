//
//  ArticleViewModel.swift
//  ShopList
//
//  Created by RK Adithya on 29/05/25.
//

import Foundation
import Combine

class ArticlesViewModel {
    
    
    private var allArticles: [Article] = []
    private(set) var displayedArticles: [Article] = []
    private let pageSize = 10
    private var currentPage = 0
    var cancellables = Set<AnyCancellable>()
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    let networkManager = NetworkManager.shared

    func fetchArticles(isRefreshing: Bool = false) {
        if isRefreshing {
            currentPage = 0
            displayedArticles.removeAll()
        }

        networkManager.fetchArticles()
            .sink(receiveCompletion: {[weak self] completion in
                
                guard let strongSelf = self else {return}
                
                switch completion{
                    
                case.failure(let error):
                    strongSelf.loadFromCache()
                    strongSelf.onError?(error.localizedDescription)

                    
                case.finished :
                    break
                }
                
            }, receiveValue: {[weak self] articles in
                guard let strongSelf = self else {return}
                strongSelf.allArticles = articles
                strongSelf.saveToCache(articles: articles)
                strongSelf.loadNextPage()
            })
            .store(in: &cancellables)
    }

    func loadNextPage() {
        let start = currentPage * pageSize
        let end = min(start + pageSize, allArticles.count)
        guard start < end else { return }

        displayedArticles.append(contentsOf: allArticles[start..<end])
        currentPage += 1
        onDataUpdated?()
    }

    func article(at index: Int) -> Article? {
        guard index >= 0 && index < displayedArticles.count else {
            return nil
        }
        return displayedArticles[index]
    }

    var totalCount: Int {
        return displayedArticles.count
    }

    private func loadFromCache() {
        
        if let data = UserDefaults.standard.data(forKey: "cachedArticles"),
           let cached = try? JSONDecoder().decode([Article].self, from: data) {
            self.allArticles = cached
            self.loadNextPage()
            
        }

    }
    
    private func saveToCache(articles: [Article]) {
        if let data = try? JSONEncoder().encode(articles) {
            UserDefaults.standard.set(data, forKey: "cachedArticles")
        }
    }

}
