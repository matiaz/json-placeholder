//
//  PostDetailsViewModel.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 6/12/22.
//

import Foundation

class PostDetailsViewModel {

    // properties
    private var service: JSONPlaceholderService

    init(_ service: JSONPlaceholderService = JSONPlaceholderService()) {
        self.service = service
    }

    func getCommentsForPost(_ postId: String) async -> Bool {
        do {
            let serviceResult = try await service.getCommentsFor(postId: postId)
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
}
