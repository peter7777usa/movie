//
//  IntroScreenViewController.swift
//  Movster
//
//  Created by Fong, Peter on 12/10/18.
//  Copyright © 2018 Fong, Peter. All rights reserved.
//

import UIKit

class IntroScreenViewController: UIViewController {
    var welcomeScreenLabel = UILabel(frame: .zero)
    var dismissButton = UIButton(frame: .zero)
    
    // MARK: - Init methods
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome"
        self.view.backgroundColor = UIColor.white
        
        /// setup welcome screen label
        self.view.addSubview(self.welcomeScreenLabel)
        self.welcomeScreenLabel.textAlignment = .center
        self.welcomeScreenLabel.lineBreakMode = .byWordWrapping
        self.welcomeScreenLabel.numberOfLines = 0
        self.welcomeScreenLabel.text = "This is an intro screen, click dismiss below"
        
        // setup Similar Movie button
        self.view.addSubview(self.dismissButton)
        self.dismissButton.setTitle("Dismiss", for: .normal)
        self.dismissButton.setTitleColor(UIColor.buttonBlue(), for: .normal)
        self.dismissButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
        
        setupConstraint()
    }
    
    // MARK: - Setup Methods
    
    private func setupConstraint () {
        
        /// setup welcome label constraints
        self.welcomeScreenLabel.translatesAutoresizingMaskIntoConstraints = false
        let welcomeScreenCenterXConstraint = NSLayoutConstraint(item: self.view, attribute: .centerX, relatedBy: .equal, toItem: self.welcomeScreenLabel, attribute: .centerX, multiplier: 1.0, constant: 0)
        let welcomeScreenCenterYConstraint = NSLayoutConstraint(item: self.view, attribute: .centerY, relatedBy: .equal, toItem: self.welcomeScreenLabel, attribute: .centerY, multiplier: 1.0, constant: 0)
        let welcomeScreenLabelLeftConstraint = NSLayoutConstraint(item: self.view, attribute: .left, relatedBy: .equal, toItem: self.welcomeScreenLabel, attribute: .left, multiplier: 1.0, constant: 0)
        let welcomeScreenLabelRightConstraint = NSLayoutConstraint(item: self.view, attribute: .right, relatedBy: .equal, toItem: self.welcomeScreenLabel, attribute: .right, multiplier: 1.0, constant: 0)
        self.view.addConstraints([welcomeScreenCenterXConstraint, welcomeScreenLabelLeftConstraint, welcomeScreenLabelRightConstraint, welcomeScreenCenterYConstraint])
        
        /// setup dismiss button constraint
        self.dismissButton.translatesAutoresizingMaskIntoConstraints = false
        let dismissButtonTopConstraint = NSLayoutConstraint(item: self.dismissButton, attribute: .top, relatedBy: .equal, toItem: self.welcomeScreenLabel, attribute: .bottom, multiplier: 1.0, constant: 30)
        let dismissButtonButtonCenterXConstraint =  NSLayoutConstraint(item: self.dismissButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0)
        self.view.addConstraints([dismissButtonTopConstraint, dismissButtonButtonCenterXConstraint])
    }
    
    // MARK: - Button Action methods
    @objc private func dismissButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}
