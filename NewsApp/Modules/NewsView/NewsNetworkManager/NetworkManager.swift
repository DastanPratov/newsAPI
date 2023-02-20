//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Dastan on 12/2/23.
//

import Foundation

protocol NetworkManagerDelegate {
    func fetchNews(name: NewsModelAPI)
    func errorFetch(error: Error)
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    var networkDelegate: NetworkManagerDelegate?
    
    let mainURL = "https://newsapi.org/v2/everything?"
    
    let apiKey = "f1ca4a2f634d4dd5b7c28fba0f269aaf"
    
    func getNewsDetails(keyWord: String, language: String) {
        let urlString = "\(mainURL)apiKey=\(apiKey)&q=\(keyWord)&language=\(language)"
        
        createRequest(urlString: urlString)
    }
    
    func createRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, responce, error in
                if let data = data {
                    if let info = self.parceJSON(data: data) {
                        self.networkDelegate?.fetchNews(name: info)
//                        print(info)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parceJSON(data: Data) -> NewsModelAPI? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(NewsModelAPI.self, from: data)
            return decodedData
        } catch {
            self.networkDelegate?.errorFetch(error: error)
            return nil
        }
    }
}
