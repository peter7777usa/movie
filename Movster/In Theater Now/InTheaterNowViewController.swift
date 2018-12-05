//
//  InTheaterNowViewController.swift
//  Movster
//
//  Created by Fong, Peter on 12/4/18.
//  Copyright © 2018 Fong, Peter. All rights reserved.
//

import UIKit

class InTheaterNowViewController: UIViewController {
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
        setupUI()
    }
    
    // MARK: - Setup methods
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "In Theaters Now"
        self.edgesForExtendedLayout = []
    }
}
