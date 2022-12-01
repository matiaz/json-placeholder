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
            let persistResponse = try await persistPost(posts: newPosts)
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
    private func persistPost(posts: [SMPost]) async throws -> Result<Bool, DataBaseError> {
        return .success(true)
    }

    // gets the comments from the endpoint and saves them locally calling the `persistComments` func
    func getCommentsFor(postId: String) async throws -> Result<Bool, ServiceError> {
        if let url = URL(string: Endpoint.getComments.url) {
            // (data, response) since we are not doing anything with the response then _ for now
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let newComments = try decoder.decode([SMComment].self, from: data)

            // save the received data locally
            let persistResponse = try await persistComments(comments: newComments)
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

    private func persistComments(comments: [SMComment]) async throws -> Result<Bool, DataBaseError> {
        return .success(true)
    }
}
