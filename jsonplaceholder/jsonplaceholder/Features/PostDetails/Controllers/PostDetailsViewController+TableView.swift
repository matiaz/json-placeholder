//
//  PostDetailsViewController+TableView.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 6/12/22.
//

import UIKit

extension PostDetailsViewController: UITableViewDelegate { }

extension PostDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return context.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentSection = context.sections[section]
        switch currentSection {
        case .postDetails, .authorDetails:
            return currentSection.rows.count
        case .comments:
            return dataProvider.fetchedResultsController.sections?.first?.numberOfObjects ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailsTableViewCell.identifier, for: indexPath) as? PostDetailsTableViewCell {
            return configuredCell(cell: cell, forRowAt: indexPath)
        } else {
            fatalError("Error on cellForWotAt - PostDetails TableView")
        }
    }

    func configuredCell(cell: PostDetailsTableViewCell, forRowAt indexPath: IndexPath) -> PostDetailsTableViewCell {
        var viewModel: PostDetailsTableViewCellViewModel
        if context.sections[indexPath.section] == .comments {
            let commentsIndexPath = IndexPath(row: indexPath.row, section: 0)
            let currentComment = dataProvider.fetchedResultsController.object(at: commentsIndexPath)
            viewModel = PostDetailsTableViewCellViewModel(comment: currentComment)
        } else {
            guard let post = selectedPost else { fatalError("Error on cellForRowAt - No post passed in") }
            let row = context.sections[indexPath.section].rows[indexPath.row]
            viewModel = PostDetailsTableViewCellViewModel(post: post, row: row)
        }
        cell.configureCell(viewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return context.sections[section].title
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
}
