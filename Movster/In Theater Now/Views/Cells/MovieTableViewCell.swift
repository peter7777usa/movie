//
//  MovieTableViewCell.swift
//  Movster
//
//  Created by Fong, Peter on 12/6/18.
//  Copyright © 2018 Fong, Peter. All rights reserved.
//

import UIKit


let movieTableViewCellIdentifier = "MovieTableViewCell"

class MovieTableViewCell: UITableViewCell {
    
    var posterImageView = UIImageView()
    var movieTitleLabel = UILabel(frame: .zero)
    
    // MARK: - Init methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        
        /// setup poster imageview
        self.posterImageView.layer.borderWidth = 0
        self.posterImageView.layer.masksToBounds = false
        self.posterImageView.translatesAutoresizingMaskIntoConstraints = false
        self.posterImageView.clipsToBounds = true
        self.contentView.addSubview(self.posterImageView)
        
        /// setup Movie title
        self.movieTitleLabel.font = UIFont.systemFont(ofSize: 15)
        self.movieTitleLabel.numberOfLines = 0
        self.movieTitleLabel.lineBreakMode = .byWordWrapping
        self.movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.movieTitleLabel)
    
        self.setupConstraintForCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupConstraintForCell() {
        
        /// Poster Image constraints
        let imageExpectedEdge = UIScreen.main.bounds.width / 4
        let posterImageViewTopConstraint = NSLayoutConstraint(item: self.posterImageView, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1.0, constant: 15)
        let posterImageViewLeftConstraint = NSLayoutConstraint(item: self.posterImageView, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1.0, constant: 15)
        let posterImageHeightConstraint = NSLayoutConstraint(item: self.posterImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: imageExpectedEdge)
        let posterImageWidthConstraint = NSLayoutConstraint(item: self.posterImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: imageExpectedEdge)
        posterImageHeightConstraint.priority = UILayoutPriority(rawValue: 999)
        let posterImageViewBottomConstraint = NSLayoutConstraint(item: self.contentView, attribute: .bottom, relatedBy: .equal, toItem: self.posterImageView, attribute: .bottom, multiplier: 1.0, constant: 15)
        self.contentView.addConstraints([posterImageViewTopConstraint, posterImageViewLeftConstraint, posterImageViewBottomConstraint, posterImageHeightConstraint, posterImageWidthConstraint])
        
        /// Movie Title constraints
        let movieTitleLeftConstraint = NSLayoutConstraint(item: self.movieTitleLabel, attribute: .left, relatedBy: .equal, toItem: self.posterImageView, attribute: .right, multiplier: 1.0, constant: 15)
        let movieTitleRightConstraint = NSLayoutConstraint(item: self.contentView, attribute: .right, relatedBy: .equal, toItem: self.movieTitleLabel, attribute: .right, multiplier: 1.0, constant: 15)
        let movieTitleCenterConstraint = NSLayoutConstraint(item: self.movieTitleLabel, attribute: .centerY, relatedBy: .equal, toItem: self.posterImageView, attribute: .centerY, multiplier: 1.0, constant: -15)
        self.contentView.addConstraints([movieTitleLeftConstraint, movieTitleRightConstraint, movieTitleCenterConstraint])
    }
    
    // MARK: - Public Methods
    
    func setupCellContent(movie: Movie) {
        self.movieTitleLabel.text = movie.title
        ImageDownloader.sharedInstance.downloadImage(imageURL: movieDBImageDownloadBaseURL + movie.posterPath, completion: { [weak self] (image) in
            DispatchQueue.main.async { [weak self] in
                self?.posterImageView.image = image
            }
        })
    }
}
