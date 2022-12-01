//
//  HomeViewController.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import UIKit

class HomeViewController: UIViewController {

    // user interface
    @IBOutlet weak var tableview: UITableView!
    private var refreshControl: UIRefreshControl!

    // properties
    internal var viewModel: HomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        // init the view model
        viewModel = HomeViewModel()


        // setup the pull to refresh logic

        // setup the swipe to favorite

        // setup the swipe to delete

        setupTableView()
        loadData()
    }

    private func setupTableView() {
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 45

        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh posts".localized)
        refreshControl.addTarget(self, action: #selector(updatePosts), for: .valueChanged)
        tableview.addSubview(refreshControl)
    }

    @objc private func updatePosts(_ sender: AnyObject) async {
        if let success = await viewModel?.updatePosts(), success {

        } else {

        }
    }

    private func loadData() {

    }
}
