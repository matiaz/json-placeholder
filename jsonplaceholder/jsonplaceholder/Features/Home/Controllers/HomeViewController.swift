//
//  HomeViewController.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import UIKit

class HomeViewController: UIViewController {

    // user interface
    @IBOutlet weak var postTableView: UITableView!
    private var refreshControl: UIRefreshControl!

    // properties
    internal var viewModel: HomeViewModel?
    lazy var dataProvider: PostDataProvider = {
        let managedContext = CoreDataManager.shared.managedContext
        let provider = PostDataProvider(with: managedContext, fetchedResultsControllerDelegate: self)
        return provider
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        // init the view model
        viewModel = HomeViewModel()

        // setup tableview
        setupTableView()

        // load data from local storage
        loadData()
    }

    private func setupTableView() {
        postTableView.rowHeight = UITableView.automaticDimension
        postTableView.estimatedRowHeight = 45
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh posts".localized)
        refreshControl.addTarget(self, action: #selector(updatePosts), for: .valueChanged)
        postTableView.addSubview(refreshControl)
    }

    @objc private func updatePosts(_ sender: AnyObject) async {
        if let success = await viewModel?.updatePosts(), success {

        } else {

        }
    }

    private func loadData() {
        
    }
}
