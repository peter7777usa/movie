//
//  MovieCollectionViewCell.swift
//  Movster
//
//  Created by Fong, Peter on 12/9/18.
//  Copyright © 2018 Fong, Peter. All rights reserved.
//

import UIKit

let movieCollectionViewCellIdentifier = "MovieCollectionViewCell"

class MovieCollectionViewCell: UICollectionViewCell {
    
    var detailController = MovieDetailsViewController()
    
    // MARK: - Init methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(movie: Movie) {
        
        ///Setup Cell Border
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        ///Use MovieDetailsController View as content view
        detailController = MovieDetailsViewController(movie: movie, embeddedInCell: true)
        self.contentView.addSubview(detailController.view)
        
        ///Setup constraint to anchor the cell with movie detail content
        detailController.view.translatesAutoresizingMaskIntoConstraints = false
        let detailViewTopConstraint = NSLayoutConstraint(item: self.detailController.view, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0)
        let detailViewLeftConstraint = NSLayoutConstraint(item: self.contentView, attribute: .left, relatedBy: .equal, toItem: detailController.view, attribute: .left, multiplier: 1.0, constant: 0)
        let detailViewRightConstraint = NSLayoutConstraint(item: self.contentView, attribute: .right, relatedBy: .equal, toItem: detailController.view, attribute: .right, multiplier: 1.0, constant: 0)
        let detailViewBottomConstraint = NSLayoutConstraint(item: self.contentView, attribute: .bottom, relatedBy: .equal, toItem: detailController.view, attribute: .bottom, multiplier: 1.0, constant: 0)
        self.contentView.addConstraints([detailViewTopConstraint,  detailViewLeftConstraint, detailViewRightConstraint, detailViewBottomConstraint])
    }
    
    // MARK: - Self Sizing Cell Methods
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let newFrame = CGRect(x: layoutAttributes.frame.origin.x, y: layoutAttributes.frame.origin.y, width: layoutAttributes.frame.width, height: detailController.view.frame.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}
