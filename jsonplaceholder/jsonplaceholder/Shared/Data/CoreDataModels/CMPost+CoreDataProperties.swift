//
//  CMPost+CoreDataProperties.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 4/12/22.
//
//

import Foundation
import CoreData


extension CMPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CMPost> {
        return NSFetchRequest<CMPost>(entityName: "CMPost")
    }

    @NSManaged public var body: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var postId: Int16
    @NSManaged public var title: String?
    @NSManaged public var userId: Int16
    @NSManaged public var comments: CMComment?

}

extension CMPost : Identifiable {
    internal class func addAndUpdate(post: SMPost) {
        let postId = post.postId ?? -1
        var currentPost: CMPost?
        let postFetch: NSFetchRequest<CMPost> = CMPost.fetchRequest()

        let predicate = NSPredicate(format: "%K == %i", #keyPath(CMPost.postId), postId)
        postFetch.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])

        do {
            let results = try CoreDataManager.shared.managedContext.fetch(postFetch)
            if results.isEmpty {
                currentPost = CMPost(context: CoreDataManager.shared.managedContext)
                currentPost?.postId = Int16(postId)
            } else {
                currentPost = results.first
            }
            currentPost?.update(item: post)
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }

    internal func update(item: SMPost) {
        body = item.body
        title = item.title
        userId = Int16(item.userId ?? -1)
    }
}
