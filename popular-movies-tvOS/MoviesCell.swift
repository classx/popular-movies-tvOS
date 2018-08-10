//
//  MoviesCell.swift
//  popular-movies-tvOS
//
//  Created by Onyekachi Samuel Ezeoke on 09/08/2018.
//  Copyright © 2018 Onyekachi Samuel Ezeoke. All rights reserved.
//

import UIKit

class MoviesCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    let BASE_URL = "http://image.tmdb.org/t/p/w500"
    
    //    var downloadedImage: UIImage!
    
    public var viewModel: Movie? {
        didSet { bindViewModel() }
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else
        { return }
        self.movieTitle.text = viewModel.title
        let posterLink = "\(BASE_URL)\(viewModel.posterPath)"
        Service.shared.downloadImage(from: posterLink) { image in
            self.movieImage.image = image
        }
    }
}
