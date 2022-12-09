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
        return dataProvider.fetchedResultsController.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        if let sections = dataProvider.fetchedResultsController.sections {
            numberOfRows = sections[section].numberOfObjects
        }
        noCommentsAvailableLabel.isHidden = numberOfRows != 0
        return numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailsTableViewCell.identifier, for: indexPath) as? PostDetailsTableViewCell {
            return configuredCell(cell: cell, forRowAt: indexPath)
        } else {
            fatalError("Error on cellForWotAt - PostDetails TableView")
        }
    }

    func configuredCell(cell: PostDetailsTableViewCell, forRowAt indexPath: IndexPath) -> PostDetailsTableViewCell {
        let currentComment = dataProvider.fetchedResultsController.object(at: indexPath)
        cell.configureCell(PostDetailsTableViewCellViewModel(comment: currentComment))
        return cell
    }
}
