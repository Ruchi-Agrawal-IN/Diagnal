//
//  MovieCollectionViewCell.swift
//  Diagnal
//
//  Created by Ruchi Agrawal on 4/7/24.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell{
    
//    @IBOutlet weak var movieImageView: UIImageView!
//    @IBOutlet weak var movieLabel: UILabel!
    
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
      }()
      
    public let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "TitilliumWeb-Regular", size: 36)
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return label
      }()
      
      private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        return stackView
      }()
      
      override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
      }
      
      required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
      }
      
      private func setupViews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        
        // Constraints for stackView (adjust as needed)
        NSLayoutConstraint.activate([
          stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0), // Adjust top inset
          stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0), // Adjust leading inset
          stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0), // Adjust trailing inset
          stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15) // Adjust bottom inset
        ])
      }
    
    func configure(withImage image: UIImage, text: String) {
        imageView.image = image
        label.text = text
      }
}
