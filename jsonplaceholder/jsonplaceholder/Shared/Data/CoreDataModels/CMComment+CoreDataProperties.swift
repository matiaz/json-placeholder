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

}
