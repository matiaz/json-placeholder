//
//  PostDetailsViewController.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import UIKit

class PostDetailsViewController: BaseViewController {

    // user interface
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // properties
    internal var context: PostDetailContext = .default
    internal var viewModel: PostDetailsViewModel!
    lazy var dataProvider: CommentDataProvider = {
        let managedContext = CoreDataManager.shared.managedContext
        let provider = CommentDataProvider(with: managedContext, fetchedResultsControllerDelegate: self)
        provider.postId = selectedPost?.postId ?? -1
        return provider
    }()
    var selectedPost: CMPost?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        viewModel = PostDetailsViewModel()
        navigationItem.title = "Post Information".localized
        setupTableView()
        activityIndicator.hidesWhenStopped = true
        Task { [weak self] in
            self?.activityIndicator.startAnimating()
            let _ = await viewModel.getCommentsForPost(selectedPost?.postId ?? -1)
            self?.activityIndicator.stopAnimating()
        }
    }

    private func setupTableView() {
        commentsTableView.register(PostDetailsTableViewCell.nib, forCellReuseIdentifier: PostDetailsTableViewCell.identifier)
        commentsTableView.estimatedRowHeight = 45
        commentsTableView.rowHeight = UITableView.automaticDimension
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
    }
}
