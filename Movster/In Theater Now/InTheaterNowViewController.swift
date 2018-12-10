//
//  InTheaterNowViewController.swift
//  Movster
//
//  Created by Fong, Peter on 12/4/18.
//  Copyright © 2018 Fong, Peter. All rights reserved.
//

import UIKit

class InTheaterNowViewController: UIViewController {
    let tableView: UITableView
    var controllerModel: InTheaterNowModel
    
    // MARK: - Init methods
    
    init() {
        self.tableView = UITableView(frame: .zero)
        self.controllerModel = InTheaterNowModel()
        super.init(nibName: nil, bundle: nil)
        self.controllerModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View controller lifecycle methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.controllerModel.getInTheaterMovies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.present(IntroScreenViewController(), animated: true, completion: nil)
    }
    
    // MARK: - Setup methods
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "In Theaters Now"
        self.edgesForExtendedLayout = []
        setupTableView()
    }
    
    private func setupTableView() {
       // self.tableView.allowsSelection = false
        //self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: movieTableViewCellIdentifier)
        self.view.addSubview(self.tableView)
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        let tableViewTopConstraint = NSLayoutConstraint(item: self.view, attribute: .top, relatedBy: .equal, toItem: self.tableView, attribute: .top, multiplier: 1.0, constant: 0)
        let tableViewLeftConstraint = NSLayoutConstraint(item: self.view, attribute: .left, relatedBy: .equal, toItem: self.tableView, attribute: .left, multiplier: 1.0, constant: 0)
        let tableViewViewRightConstraint = NSLayoutConstraint(item: self.view, attribute: .right, relatedBy: .equal, toItem: self.tableView, attribute: .right, multiplier: 1.0, constant: 0)
        let tableViewViewBottomConstraint = NSLayoutConstraint(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: self.tableView, attribute: .bottom, multiplier: 1.0, constant: 0)
        self.view.addConstraints([tableViewTopConstraint,  tableViewLeftConstraint, tableViewViewRightConstraint, tableViewViewBottomConstraint])
    }
}

// MARK: - TableView Delegate and Datasource

extension InTheaterNowViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controllerModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieTableViewCellIdentifier, for: indexPath) as? MovieTableViewCell
        cell?.setupCellContent(movie: self.controllerModel.movies[indexPath.row])
        return cell ?? MovieTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(MovieDetailsViewController(movie: controllerModel.movies[indexPath.row]), animated: true)
    }
}

// MARK: - InTheaterNowModelDelegate

extension InTheaterNowViewController: InTheaterNowModelDelegate {
    func updateMovieData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
