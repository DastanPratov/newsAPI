//
//  ImageNetworkService.swift
//  NewsApp
//
//  Created by Dastan on 13/2/23.
//

import Foundation

class ImageNetworkSevice {
    
    static let shared = ImageNetworkSevice()
    
    func createImgaeRequest(imageURL: String, completion: ((Data) -> Void)?) {
        let url = URL(string: imageURL)
        if let url = url {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, responce, errror in
                if let data = data {
                    completion!(data)
                }
            }
            task.resume()
        }
        
    }
}
