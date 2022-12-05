//
//  CoreDataManager.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import Foundation
import CoreData

final class CoreDataManager: NSObject {
    static var shared: CoreDataManager!
    private let model: String = "jsonplaceholder"

    // MARK: - Core Data stack
    lazy var managedContext: NSManagedObjectContext = self.persistentContainer.viewContext

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "jsonplaceholder")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func getPosts() async -> [CMPost] {
        let postsFetch: NSFetchRequest<CMPost> = CMPost.fetchRequest()
        let sortId = NSSortDescriptor(key: #keyPath(CMPost.postId), ascending: true)
        postsFetch.sortDescriptors = [sortId]
        do {
            let managedContext = self.managedContext
            let results = try managedContext.fetch(postsFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
            return []
        }
    }

    func getComments() async -> [CMComment] {
        let commentsFetch: NSFetchRequest<CMComment> = CMComment.fetchRequest()
        let sortId = NSSortDescriptor(key: #keyPath(CMComment.postId), ascending: true)
        commentsFetch.sortDescriptors = [sortId]
        do {
            let managedContext = self.managedContext
            let results = try managedContext.fetch(commentsFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
            return []
        }
    }

    func set(post: CMPost, favorite: Bool) async -> Bool {
        post.favorite = favorite
        saveContext()
        return true
    }
}
