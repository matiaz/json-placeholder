//
//  HomeViewController+TableView.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import UIKit

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal, title: "Favourite".localized) { [weak self] (action, view, completion) in
            if let sections = self?.dataProvider.fetchedResultsController.sections,
               let rows = sections[indexPath.section].objects,
                let currentPost = rows[indexPath.row] as? CMPost {
                self?.viewModel?.set(post: currentPost, favorite: !currentPost.favorite, completion: { result in
                    // update the UI here
                    self?.postTableView.beginUpdates()
                    self?.postTableView.endUpdates()
                })
            }
        }
        favoriteAction.backgroundColor = UIColor.systemYellow
        let configuration = UISwipeActionsConfiguration(actions: [favoriteAction])
        return configuration
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete".localized) { [weak self] (action, view, completion) in
            if let sections = self?.dataProvider.fetchedResultsController.sections,
               let rows = sections[indexPath.section].objects,
                let currentPost = rows[indexPath.row] as? CMPost {
                self?.viewModel?.delete(post: currentPost, completion: { result in
                    // update the UI here
                    self?.postTableView.beginUpdates()
                    self?.postTableView.endUpdates()
                })
            }
        }
        deleteAction.backgroundColor = UIColor.systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataProvider.fetchedResultsController.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        if let sections = dataProvider.fetchedResultsController.sections {
            numberOfRows = sections[section].numberOfObjects
        }
        noPostsAvailableLabel.isHidden = numberOfRows != 0
        return numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath)
        configureCell(cell: cell, forRowAt: indexPath)
        return cell
    }

    func configureCell(cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = self.postTableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell {
            let currentPost = dataProvider.fetchedResultsController.object(at: indexPath)
            cell.viewModel = PostTableViewCellViewModel(post: currentPost)
        }
    }
}
