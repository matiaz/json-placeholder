//
//  PostDetailViewController+FetchResultController.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 7/12/22.
//

import UIKit
import Foundation
import CoreData

extension PostDetailsViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        commentsTableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            commentsTableView.insertSections(IndexSet(integer: sectionIndex), with: .none)
        case .delete:
            commentsTableView.deleteSections(IndexSet(integer: sectionIndex), with: .none)
        default:
            break
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            commentsTableView.insertRows(at: [newIndexPath!], with: .none)
        case .delete:
            commentsTableView.deleteRows(at: [indexPath!], with: .none)
        case .move:
            commentsTableView.deleteRows(at: [indexPath!], with: .none)
            commentsTableView.insertRows(at: [newIndexPath!], with: .none)
        case .update:
            guard let cell = commentsTableView.dequeueReusableCell(withIdentifier: PostDetailsTableViewCell.identifier,
                                                           for: indexPath!) as? PostDetailsTableViewCell else { fatalError("xib doesn't exist") }
            let comment = dataProvider.fetchedResultsController.object(at: indexPath!)
            
            let viewModel = PostDetailsTableViewCellViewModel(comment: comment)
            cell.configureCell(viewModel)
        default:
            break
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        commentsTableView.endUpdates()
    }
}
