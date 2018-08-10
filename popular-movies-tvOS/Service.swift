//
//  Service.swift
//  popular-movies-tvOS
//
//  Created by Onyekachi Samuel Ezeoke on 09/08/2018.
//  Copyright © 2018 Onyekachi Samuel Ezeoke. All rights reserved.
//

import Foundation
import UIKit

public class Service {
    private init() {}
    static let shared = Service()
    
    public func fetchRecords(completion: @escaping ([Movie]) -> Void) {
        guard let pathURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=e749115c015e01a7058b36bf861ded0f")
            else { return }
        let request = URLRequest(url: pathURL)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error.debugDescription)
            } else {
                do {
                    let records = try JSONDecoder().decode(Movies.self, from: data!)
                    completion(records.results)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    public func downloadImage(from imageURL: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: imageURL) else { return }
        
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        completion(image)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

