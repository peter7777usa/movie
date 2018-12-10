//
//  SimilarMoviesViewController.swift
//  Movster
//
//  Created by Fong, Peter on 12/9/18.
//  Copyright © 2018 Fong, Peter. All rights reserved.
//

import UIKit

class SimilarMoviesViewController: UIViewController {
    static var collectionItemSize: CGSize {
        var shorterEdge = UIScreen.main.bounds.width
        if shorterEdge > UIScreen.main.bounds.height {
            shorterEdge = UIScreen.main.bounds.height
        }
        return CGSize(width: shorterEdge * 0.75, height: 500)
    }

    let collectionView: UICollectionView
    var controllerModel: SimilarMoviesModel
    weak var delegate: SimilarMoviesModelDelegate?

    // MARK: - Init methods
    
    init() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.estimatedItemSize = SimilarMoviesViewController.collectionItemSize
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        self.controllerModel = SimilarMoviesModel()
        super.init(nibName: nil, bundle: nil)
        self.controllerModel.delegate = self
    }
    
    convenience init(movie: Movie?) {
        self.init()
        self.controllerModel.currentMovieTarget = movie
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Similar Movies"
        setupCollectionView()
        self.controllerModel.getSimilarMovies()
    }
    
    // MARK: - Orientation Change Method
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
       // layoutInset = size.width / 2 - SimilarMoviesViewController.photoItemSize.width / 2
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - Setup Methods
    
    private func setupCollectionView() {
        self.collectionView.contentInsetAdjustmentBehavior = .never
        self.collectionView.decelerationRate =  UIScrollView.DecelerationRate.fast
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: movieCollectionViewCellIdentifier)
        self.view.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.clipsToBounds = false
        setupCollectionViewConstraint()
    }
    
    private func setupCollectionViewConstraint () {
        let collectionViewTopConstraint = NSLayoutConstraint(item: self.view, attribute: .top, relatedBy: .equal, toItem: self.collectionView, attribute: .top, multiplier: 1.0, constant: 0)
        let collectionViewLeftConstraint = NSLayoutConstraint(item: self.view, attribute: .left, relatedBy: .equal, toItem: self.collectionView, attribute: .left, multiplier: 1.0, constant: 0)
        let collectionViewRightConstraint = NSLayoutConstraint(item: self.view, attribute: .right, relatedBy: .equal, toItem: self.collectionView, attribute: .right, multiplier: 1.0, constant: 0)
        let collectionViewBottomConstraint = NSLayoutConstraint(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: self.collectionView, attribute: .bottom, multiplier: 1.0, constant: 0)
        self.view.addConstraints([collectionViewTopConstraint,  collectionViewLeftConstraint, collectionViewRightConstraint, collectionViewBottomConstraint])
    }
    
    // MARK: - Private Methods
    
    /// Use to snap cell position to the closest position of a cell so the
    /// deceleration to full stop of the collection view wont end up in between
    /// cell
    ///
    /// - Parameters:
    ///   - targetContentOffsetX: the original position the collection intended to end up
    /// - Returns: The after calculation closet cell position we want it to end up
    private func nextClosestCellOffsetX(targetContentOffsetX: CGFloat) -> CGFloat {
        var convertedOffset = CGFloat(Int(targetContentOffsetX / SimilarMoviesViewController.collectionItemSize.width)) *  SimilarMoviesViewController.collectionItemSize.width
        if targetContentOffsetX - convertedOffset > SimilarMoviesViewController.collectionItemSize.width / 2 {
            convertedOffset = convertedOffset + SimilarMoviesViewController.collectionItemSize.width
        }
        return convertedOffset
    }
}

// MARK: - CollectionView Datasource

extension SimilarMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCollectionViewCellIdentifier, for: indexPath) as? MovieCollectionViewCell
        cell?.setupCell(movie: controllerModel.movies[indexPath.row])
        return cell ?? MovieCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.controllerModel.movies.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

// MARK: - CollectionView Delegate

extension SimilarMoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(MovieDetailsViewController(movie: self.controllerModel.movies[indexPath.row]), animated: true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee.x = nextClosestCellOffsetX(targetContentOffsetX:  targetContentOffset.pointee.x)
    }
}

// MARK: - SimilarMoviesModel Delegate

extension SimilarMoviesViewController: SimilarMoviesModelDelegate {
    func updateMoviesData() {
        DispatchQueue.main.async { [weak self] in
            if self?.controllerModel.movies.count == 0 {
                self?.navigationController?.popViewController(animated: true)
            }
            self?.collectionView.reloadData()
        }
    }
}
