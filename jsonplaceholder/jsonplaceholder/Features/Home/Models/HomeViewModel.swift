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
    func getPosts() async -> [String] {
        return []
    }

    // sets the favorite post property to true or false
    func set(post: String, isFavorite: Bool) async -> Bool {
        return true
    }

    // deletes a post from the local storage
    func delete(post: String) async -> Bool {
        return true
    }
}
