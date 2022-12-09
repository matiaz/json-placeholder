//
//  HomeViewController.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import UIKit

class HomeViewController: BaseViewController {

    // user interface
    @IBOutlet weak var postTableView: UITableView!
    private var refreshControl: UIRefreshControl!
    @IBOutlet weak var noPostsAvailableLabel: UILabel!

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
        navigationItem.title = "Placeholder Posts".localized
        setupTableView()
        viewModel = HomeViewModel()
        noPostsAvailableLabel.isHidden = true
        postTableView.reloadData()
    }

    private func setupTableView() {
        postTableView.rowHeight = UITableView.automaticDimension
        postTableView.register(PostTableViewCell.nib, forCellReuseIdentifier: PostTableViewCell.identifier)
        postTableView.estimatedRowHeight = 45
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh posts".localized)
        refreshControl.addTarget(self, action: #selector(updatePosts), for: .valueChanged)
        postTableView.addSubview(refreshControl)
        postTableView.dataSource = self
        postTableView.delegate = self
    }

    private func updatePostsAction() async {
        refreshControl.beginRefreshing()
        if let _ = await viewModel?.updatePosts() {
            refreshControl.endRefreshing()
        }
    }

    @objc private func updatePosts(_ sender: AnyObject) {
        Task {
            await updatePostsAction()
        }
    }
}
