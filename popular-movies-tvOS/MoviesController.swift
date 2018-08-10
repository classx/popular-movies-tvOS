//
//  ViewController.swift
//  popular-movies-tvOS
//
//  Created by Onyekachi Samuel Ezeoke on 09/08/2018.
//  Copyright © 2018 Onyekachi Samuel Ezeoke. All rights reserved.
//

import UIKit

class MoviesController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    var movies: [Movie] = []
    let defaultSize = CGSize(width: 414, height: 582)
    let focusSize = CGSize(width: 621, height: 873)
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.delegate = self
        collectionview.dataSource = self
        downloadData()
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCellID", for: indexPath) as? MoviesCell
            else { return MoviesCell() }
        
        if cell.gestureRecognizers?.count == nil {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
            tap.allowedPressTypes = [NSNumber(integerLiteral: UIPressType.select.rawValue)]
            cell.addGestureRecognizer(tap)
        }
        cell.viewModel = movies[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 379, height: 698)
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let prev = context.previouslyFocusedView as? MoviesCell {
            UIView.animate(withDuration: 0.1) {
                prev.movieImage.frame.size = self.defaultSize
            }
        }
        
        if let next = context.nextFocusedView as? MoviesCell {
            UIView.animate(withDuration: 0.1) {
                next.movieImage.frame.size = self.focusSize
            }
        }
    }
    
    @objc private func tapped(gesture: UITapGestureRecognizer) {
        
        if let cell = gesture.view as? MoviesCell {
            // Load the next view controller and pass on the data
            print("Movie title is: \(cell.movieTitle.text!)")
        }
        
    }
    
    private func downloadData() {
        Service.shared.fetchRecords(completion: { movies in
            DispatchQueue.main.async {
                self.movies = movies
                self.collectionview.reloadData()
            }
        })
        
    }
}

