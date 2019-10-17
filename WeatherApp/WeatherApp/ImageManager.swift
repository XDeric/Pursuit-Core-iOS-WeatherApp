//
//  ImageManager.swift
//  WeatherApp
//
//  Created by EricM on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation


final class ImageManager {
    
    private init() {}
    
    static let manager = ImageManager()
    
    func getImage(search: String ,completionHandler: @escaping (Result<[Hits], AppError>) -> () ) {
        
        //let searchNameForatted = search.replacingOccurrences(of: " ", with: "-")
        
        let stringURL = "https://pixabay.com/api/?key=\(Secret.pixaKey)&q=\(search)"
        
        guard let url = URL(string: stringURL) else {
            completionHandler(.failure(.badURL))
            return
        }
        NetworkHelper.manager.performDataTask(withURL: url, andMethod: .get, completionHandler: { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let imageData = try JSONDecoder().decode(Total.self, from: data)
                    completionHandler(.success(imageData.hits ))
                } catch {
                    print(error)
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        })
    }
}
