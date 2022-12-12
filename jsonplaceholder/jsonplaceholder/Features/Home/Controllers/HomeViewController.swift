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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deletePosts))
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

    private func presentDeletePostsAlert() {
        let alertMessage = "Delete all the posts except the favourites?".localized
        let alertController = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes".localized, style: .destructive) { [weak self] _ in
            self?.viewModel?.deletePosts(completion: { _ in
                self?.presentDeletePostsFinishAlert()
            })
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel)
        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    private func presentDeletePostsFinishAlert() {
        let alertMessage = "All posts have been deleted sucessfully".localized
        let alertController = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok".localized, style: .default)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }

    @objc private func updatePosts(_ sender: AnyObject) {
        Task {
            await updatePostsAction()
        }
    }

    @objc private func deletePosts(_ sender: AnyObject) {
        presentDeletePostsAlert()
    }
}
