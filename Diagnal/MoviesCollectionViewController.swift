//
//  MoviesCllectionViewController.swift
//  Diagnal
//
//  Created by Ruchi Agrawal on 4/7/24.
//

import Foundation
import UIKit
class MoviesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    private var currentPage = 1
    private var totalPages = 4
    private var isLoadingMore = false
    let numberOfItemsPerRow = 3 // Set your desired number of items per row
    private let itemHeight: CGFloat = 100
//    private var movies;
    private var movies : [MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "movieCell")
        let yourBackImage = UIImage(named: "Back")

        navigationController?.navigationBar.backIndicatorImage = yourBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        navigationController?.navigationBar.tintColor = .white;
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Romantic Comedy", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "nav_bar"), for: .default)
        let myimage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
         navigationItem.rightBarButtonItem = UIBarButtonItem(image: myimage, style: .plain, target: self, action: #selector(ButtonTapped))
        loadMoreData()
    }
    
    @objc func ButtonTapped() {
        print("Button Tapped")
   }
    
    @objc private func popToPrevious() {
        // our custom stuff
        navigationController?.popViewController(animated: true)
    }
    
    func loadMoreData() {
        isLoadingMore = true
        fetchData(forPage: currentPage) { [weak self] result in
          guard let self = self else { return }
          defer { self.isLoadingMore = false }
          switch result {
          case .success(let newMovies):
            self.movies.append(contentsOf: newMovies)
            self.collectionView.reloadData()
            self.currentPage += 1
          case .failure(let error):
            print("Error fetching data: \(error)")
          }
        }
      }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 30) / CGFloat(numberOfItemsPerRow))
        return CGSize(width: width, height: (width*(1.5)+50))
    }
    
    // Mark: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
    
        // Configure the cell
        let movie = movies[indexPath.row]
        cell.label.text = movie.name
        cell.imageView.image = UIImage(named: movie.image)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastSection = collectionView.numberOfSections - 1
        let lastItem = collectionView.numberOfItems(inSection: lastSection) - 1
        if indexPath.section == lastSection && indexPath.item == lastItem && !isLoadingMore && currentPage < totalPages { // Check for total pages
            loadMoreData()
        }
    }

}
