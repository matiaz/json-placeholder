//
//  CMComment+CoreDataProperties.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 4/12/22.
//
//

import Foundation
import CoreData


extension CMComment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CMComment> {
        return NSFetchRequest<CMComment>(entityName: "CMComment")
    }

    @NSManaged public var body: String?
    @NSManaged public var email: String?
    @NSManaged public var commentId: Int16
    @NSManaged public var name: String?
    @NSManaged public var postId: Int16
    @NSManaged public var post: CMPost?

}

extension CMComment : Identifiable {
    internal class func addAndUpdate(_ comment: SMComment, _ postId: Int16) {
        let commentId = comment.id ?? -1
        var currentComments: CMComment?
        let commentFetch: NSFetchRequest<CMComment> = CMComment.fetchRequest()

        let predicate = NSPredicate(format: "%K == %i", #keyPath(CMComment.commentId), commentId)
        commentFetch.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])

        do {
            let results = try CoreDataManager.shared.managedContext.fetch(commentFetch)
            if results.isEmpty {
                currentComments = CMComment(context: CoreDataManager.shared.managedContext)
                currentComments?.commentId = Int16(commentId)
            } else {
                currentComments = results.first
            }
            currentComments?.postId = postId
            currentComments?.update(comment)
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }

    internal func update(_ item: SMComment) {
        body = item.body
        email = item.email
        name = item.name
    }
}
