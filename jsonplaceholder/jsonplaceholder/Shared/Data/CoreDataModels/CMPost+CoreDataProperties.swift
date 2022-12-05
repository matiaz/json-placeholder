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

}
