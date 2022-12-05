//
//  HomeViewController+FetchResultController.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 4/12/22.
//

import UIKit
import Foundation
import CoreData

extension HomeViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.postTableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            postTableView.insertSections(IndexSet(integer: sectionIndex), with: .none)
        case .delete:
            postTableView.deleteSections(IndexSet(integer: sectionIndex), with: .none)
        default:
            break
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            postTableView.insertRows(at: [newIndexPath!], with: .none)
        case .delete:
            postTableView.deleteRows(at: [indexPath!], with: .none)
        case .move:
            postTableView.deleteRows(at: [indexPath!], with: .none)
            postTableView.insertRows(at: [newIndexPath!], with: .none)
        case .update:
            guard let cell = postTableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier,
                                                           for: indexPath!) as? PostTableViewCell else { fatalError("xib doesn't exist") }
            let post = dataProvider.fetchedResultsController.object(at: indexPath!)
            cell.postTitleLabel.text = post.title

            cell.postFavoriteImageView.isHidden = !post.favorite
        default:
            break
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        postTableView.endUpdates()
    }
}
