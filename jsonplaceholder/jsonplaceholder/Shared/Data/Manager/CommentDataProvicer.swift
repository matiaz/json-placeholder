//
//  CommentDataProvicer.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 7/12/22.
//

import UIKit
import CoreData

class CommentDataProvider {
    private(set) var managedObjectContext: NSManagedObjectContext
    private weak var fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?
    var postId: Int16?

    init(with managedObjectContext: NSManagedObjectContext, fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?) {
        self.managedObjectContext = managedObjectContext
        self.fetchedResultsControllerDelegate = fetchedResultsControllerDelegate
    }

    lazy var fetchedResultsController: NSFetchedResultsController<CMComment> = {
        let fetchRequest: NSFetchRequest<CMComment> = CMComment.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(CMComment.commentId), ascending: false)]
        let predicate = NSPredicate(format: "%K == %i", #keyPath(CMComment.postId),  postId ?? -1)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = fetchedResultsControllerDelegate

        do {
            try controller.performFetch()
        } catch {
            print("Fetch failed")
        }
        return controller
    }()
}

