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
        let favoriteAction = UIContextualAction(style: .normal,
                                                title: "Favourite".localized) { [weak self] (action, view, completion) in
            if let currentPost = self?.viewModel?.posts[indexPath.row], let postId = currentPost.id {
                self?.viewModel?.set(postId: postId, favorite: true, completion: { result in
                    completion(result)
                })
            } else {
                completion(false)
            }
        }
        favoriteAction.backgroundColor = UIColor.systemYellow
        let configuration = UISwipeActionsConfiguration(actions: [favoriteAction])
        return configuration
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal,
                                                title: "Delete".localized) { [weak self] (action, view, completion) in
            if let currentPost = self?.viewModel?.posts[indexPath.row], let postId = currentPost.id {
                self?.viewModel?.delete(postId: postId, completion: { result in
                    completion(result)
                })
            } else {
                completion(false)
            }
        }
        deleteAction.backgroundColor = UIColor.systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        configureCell(cell: cell, forRowAt: indexPath)
        return cell
    }

    func configureCell(cell: UITableViewCell, forRowAt indexPath: IndexPath) {

    }
}
