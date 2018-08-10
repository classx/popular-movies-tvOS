//
//  MovieModel.swift
//  popular-movies-tvOS
//
//  Created by Onyekachi Samuel Ezeoke on 09/08/2018.
//  Copyright © 2018 Onyekachi Samuel Ezeoke. All rights reserved.
//

import Foundation

public struct Movie: Decodable {
    let title: String
    let overview: String
    let posterPath: String
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case overview
    }
}

public struct Movies: Decodable {
    let results: [Movie]
}




