//
//  JSONPlaceholderService.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import Foundation

class JSONPlaceholderService: NSObject {

    // gets the posts from the endpoint and saves them locally calling the `persistPost` func
    func getPosts() async throws -> Result<Bool, ServiceError> {
        if let url = URL(string: Endpoint.getPosts.url) {
            // (data, response) since we are not doing anything with the response then _ for now
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let newPosts = try decoder.decode([SMPost].self, from: data)

            // save the received data locally
            let persistResponse = await persistPost(posts: newPosts)
            switch persistResponse {
            case .success(let result):
                return .success(result)
            case .failure(_):
                return .failure(.defaultError)
            }
        } else {
             // handle the error here
            return .failure(.defaultError)
        }
    }

    // persists the posts locally
    private func persistPost(posts: [SMPost]) async -> Result<Bool, DataBaseError> {
        for post in posts {
            CMPost.addAndUpdate(post: post)
            CoreDataManager.shared.saveContext()
        }
        return .success(true)
    }

    // gets the comments from the endpoint and saves them locally calling the `persistComments` func
    func getCommentsFor(postId: String) async throws -> Result<Bool, ServiceError> {
        if let url = URL(string: Endpoint.getComments.url + postId) {
            // (data, response) since we are not doing anything with the response then _ for now
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let newComments = try decoder.decode([SMComment].self, from: data)

            // save the received data locally
            let persistResponse = try await persistComments(comments: newComments, Int16(postId) ?? -1)
            switch persistResponse {
            case .success(let result):
                return .success(result)
            case .failure(_):
                return .failure(.defaultError)
            }
        } else {
             // handle the error here
            return .failure(.defaultError)
        }
    }

    private func persistComments(comments: [SMComment], _ postId: Int16) async throws -> Result<Bool, DataBaseError> {
        for comment in comments {
            CMComment.addAndUpdate(comment, postId)
            CoreDataManager.shared.saveContext()
        }
        return .success(true)
    }
}
