//
//  MovieDetailsViewController.swift
//  Movster
//
//  Created by Fong, Peter on 12/8/18.
//  Copyright © 2018 Fong, Peter. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var scrollView = UIScrollView(frame: .zero)
    var posterImageView = UIImageView()
    var movieTitleLabel = UILabel(frame: .zero)
    var genereLabel = UILabel(frame: .zero)
    var releaseDateLabel = UILabel(frame: .zero)
    var ratingLabel = UILabel(frame: .zero)
    var movieDescriptionLabel = UILabel(frame: .zero)
    var movie: Movie?
    var similarMoviesButton = UIButton(frame: .zero)
    var isEmbeddedInCell = false
    
    // MARK: - Init methods
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(movie: Movie, embeddedInCell: Bool = false) {
        self.init()
        self.movie = movie
        self.isEmbeddedInCell = embeddedInCell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupControllerContents()
    }
    
    // MARK: - Setup methods
    
    private func setupUI() {
        self.view.addSubview(self.scrollView)
        self.view.backgroundColor = UIColor.white
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.addSubview(self.movieTitleLabel)
        self.scrollView.addSubview(self.posterImageView)
        self.scrollView.addSubview(self.movieTitleLabel)
        self.scrollView.addSubview(self.genereLabel)
        self.scrollView.addSubview(self.releaseDateLabel)
        self.scrollView.addSubview(self.ratingLabel)
        self.scrollView.addSubview(self.movieDescriptionLabel)
        self.scrollView.addSubview(self.similarMoviesButton)
        
        /// setup Movie title label
        self.movieTitleLabel.font = UIFont.systemFont(ofSize: 15)
        self.movieTitleLabel.numberOfLines = 0
        self.movieTitleLabel.lineBreakMode = .byWordWrapping
        
        /// setup Movie Genre Label
        self.genereLabel.font = UIFont.systemFont(ofSize: 12)
        self.genereLabel.numberOfLines = 0
        self.genereLabel.lineBreakMode = .byWordWrapping
        self.genereLabel.textAlignment = .center
        
        /// setup Movie Description Label
        self.movieDescriptionLabel.font = UIFont.systemFont(ofSize: 17)
        self.movieDescriptionLabel.numberOfLines = 0
        self.movieDescriptionLabel.lineBreakMode = .byWordWrapping
        
        if self.isEmbeddedInCell {
            self.similarMoviesButton.isHidden = true
        } else {

            // setup Similar Movie button
            self.similarMoviesButton.setTitle("Similar Movies", for: .normal)
            self.similarMoviesButton.setTitleColor(UIColor.init(red: 0, green: 122/255, blue: 1, alpha: 1), for: .normal)
            self.similarMoviesButton.addTarget(self, action: #selector(similarMovieButtonClicked), for: .touchUpInside)
        }
    }
    
    private func setupConstraints() {

        /// Scroll View Constriants
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        guard let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaInsets.top else { return }
        let scrollViewTopConstraint = NSLayoutConstraint(item: self.scrollView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: safeAreaHeight + 44)
        let scrollViewBottomConstraint = NSLayoutConstraint(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: self.scrollView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let scrollViewLeftConstraint = NSLayoutConstraint(item: self.view, attribute: .left, relatedBy: .equal, toItem: self.scrollView, attribute: .left, multiplier: 1.0, constant: 0)
        let scrollViewRightConstraint = NSLayoutConstraint(item: self.view, attribute: .right, relatedBy: .equal, toItem: self.scrollView, attribute: .right, multiplier: 1.0, constant: 0)
        self.view.addConstraints([scrollViewTopConstraint, scrollViewBottomConstraint, scrollViewLeftConstraint, scrollViewRightConstraint])
        
        /// Poster ImageView Constriants
        self.posterImageView.translatesAutoresizingMaskIntoConstraints = false
        let posterImageViewTopConstraint = NSLayoutConstraint(item: self.posterImageView, attribute: .top, relatedBy: .equal, toItem: self.scrollView, attribute: .top, multiplier: 1.0, constant: 15)
        let posterImageCenterXConstraint =  NSLayoutConstraint(item: self.posterImageView, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0)
        self.scrollView.addConstraints([posterImageViewTopConstraint, posterImageCenterXConstraint])
        
        /// Movie Title Label Constraints
        self.movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        let movieTitleLabelTopConstraint = NSLayoutConstraint(item: self.movieTitleLabel, attribute: .top, relatedBy: .equal, toItem: self.posterImageView, attribute: .bottom, multiplier: 1.0, constant: 15)
        let movieTitleLabelCenterXConstraint =  NSLayoutConstraint(item: self.movieTitleLabel, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0)
        self.scrollView.addConstraints([movieTitleLabelTopConstraint, movieTitleLabelCenterXConstraint])
        
        /// Genere Label Constraints
        self.genereLabel.translatesAutoresizingMaskIntoConstraints = false
        let genereLabelTopConstraint = NSLayoutConstraint(item: self.genereLabel, attribute: .top, relatedBy: .equal, toItem: self.movieTitleLabel, attribute: .bottom, multiplier: 1.0, constant: 15)
        let genereLabelCenterXConstraint =  NSLayoutConstraint(item: self.genereLabel, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0)
        let genereLabelLabelWidthConstraint = NSLayoutConstraint(item: self.genereLabel, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 1.0, constant: -30)
        self.scrollView.addConstraints([genereLabelTopConstraint, genereLabelCenterXConstraint, genereLabelLabelWidthConstraint])
        
        /// Release Label Constraints
        self.releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        let releaseDateLabelTopConstraint = NSLayoutConstraint(item: self.releaseDateLabel, attribute: .top, relatedBy: .equal, toItem: self.genereLabel, attribute: .bottom, multiplier: 1.0, constant: 15)
        let releaseDateLabelCenterXConstraint =  NSLayoutConstraint(item: self.releaseDateLabel, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0)
        self.scrollView.addConstraints([releaseDateLabelTopConstraint, releaseDateLabelCenterXConstraint])
        
        /// Rating Label Constraints
        self.ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        let ratingLabelTopConstraint = NSLayoutConstraint(item: self.ratingLabel, attribute: .top, relatedBy: .equal, toItem: self.releaseDateLabel, attribute: .bottom, multiplier: 1.0, constant: 15)
        let ratingLabelCenterXConstraint =  NSLayoutConstraint(item: self.ratingLabel, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0)
        self.scrollView.addConstraints([ratingLabelTopConstraint, ratingLabelCenterXConstraint])
        
        /// Movie Description Constraints
        self.movieDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let movieDescriptionLabelTopConstraint = NSLayoutConstraint(item: self.movieDescriptionLabel, attribute: .top, relatedBy: .equal, toItem: self.ratingLabel, attribute: .bottom, multiplier: 1.0, constant: 45)
        let movieDescriptionLabelWidthConstraint = NSLayoutConstraint(item: self.movieDescriptionLabel, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 1.0, constant: -30)
        let movieDescriptionLabelCenterXConstraint =  NSLayoutConstraint(item: self.movieDescriptionLabel, attribute: .centerX, relatedBy: .equal, toItem: self.ratingLabel, attribute: .centerX, multiplier: 1.0, constant: 0)
        self.scrollView.addConstraints([movieDescriptionLabelTopConstraint, movieDescriptionLabelWidthConstraint, movieDescriptionLabelCenterXConstraint])
        
        /// Similar Movies Button Constraints
        self.similarMoviesButton.translatesAutoresizingMaskIntoConstraints = false
        let similarMoviesButtonTopConstraint = NSLayoutConstraint(item: self.similarMoviesButton, attribute: .top, relatedBy: .equal, toItem: self.movieDescriptionLabel, attribute: .bottom, multiplier: 1.0, constant: 30)
        let similarMoviesButtonCenterXConstraint =  NSLayoutConstraint(item: self.similarMoviesButton, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0)
        let  similarMoviesButtonBottomConstraint =  NSLayoutConstraint(item: self.scrollView, attribute: .bottom, relatedBy: .equal, toItem: self.similarMoviesButton, attribute: .bottom, multiplier: 1.0, constant: 75)
        self.scrollView.addConstraints([similarMoviesButtonTopConstraint, similarMoviesButtonCenterXConstraint, similarMoviesButtonBottomConstraint])
    }
    
    private func setupControllerContents() {
        guard let movieModel = self.movie else { return }
        self.movieTitleLabel.text = movieModel.title
        var genreTexts = ""
        for genreID in movieModel.genereIDs {
            guard let genreName = GenreMapping.sharedInstance.mapping[genreID] else { return }
            genreTexts = genreTexts + genreName + "/"
        }
        genreTexts.removeLast()
        self.genereLabel.text = genreTexts
        self.releaseDateLabel.text = "RELEASE DATE: " + movieModel.releaseData
        self.ratingLabel.text = "RATING: " + String(movieModel.voteAverage)
        self.movieDescriptionLabel.text = movieModel.overview
        
        ImageDownloader.sharedInstance.downloadImage(imageURL: movieDBImageDownloadBaseURL + movieModel.posterPath, completion: { [weak self] (image) in
            DispatchQueue.main.async { [weak self] in
                self?.posterImageView.image = image
            }
        })
    }
    
    // MARK: - Button Action methods
    @objc func similarMovieButtonClicked() {
        self.navigationController?.pushViewController(SimilarMoviesViewController(movie: self.movie), animated: true)
    }
}
