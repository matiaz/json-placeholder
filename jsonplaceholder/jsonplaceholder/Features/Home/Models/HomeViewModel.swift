//
//  HomeViewModel.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import Foundation

class HomeViewModel: NSObject {

    var service: JSONPlaceholderService!

    // custom init in case we need it
    init(service: JSONPlaceholderService? = JSONPlaceholderService()) {
        super.init()
        self.service = service
    }

    // updates the posts from the back end and stores them locally
    func updatePosts() async -> Bool {
        do {
            let serviceResult = try await service.getPosts()
            switch serviceResult {
            case .success(_):
                return true
            case .failure(_):
                return false
            }
        } catch {
            return false
        }
    }

    // toggles the favorite property
    func set(post: CMPost, favorite: Bool, completion: @escaping (Bool) -> Void) {
        Task {
            let result = await CoreDataManager.shared.set(post: post, favorite: favorite)
            DispatchQueue.main.async { completion(result) }
        }
    }

    // sets the favorite post property to true or false
    func set(postId: Int, favorite: Bool) async -> Bool {
        return true
    }

    // deletes a post from the local storage
    func delete(post: CMPost, completion: @escaping (Bool) -> Void) {
        Task {
            let result = await CoreDataManager.shared.deletePost(post: post)
            DispatchQueue.main.async { completion(result) }
        }
    }
}
