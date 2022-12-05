//
//  HomeViewModel.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import Foundation

class HomeViewModel: NSObject {

    // custom init in case we need it
    override init() { super.init() }

    // updates the posts from the back end and stores them locally
    func updatePosts() async -> Bool {
        return true
    }

    // gets the total amount of posts
    func getPostsCount() async -> Int {
        return 0
    }

    // gets the list of posts stored locally
    func getPosts() async -> Bool {
        return true
    }

    func set(post: CMPost, favorite: Bool, completion: @escaping (Bool) -> Void) {
        Task {
            let result = await CoreDataManager.shared.set(post: post, favorite: favorite)
            completion(result)
        }
    }

    // sets the favorite post property to true or false
    func set(postId: Int, favorite: Bool) async -> Bool {
        return true
    }

    // deletes a post from the local storage
    func delete(post: CMPost, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
}
