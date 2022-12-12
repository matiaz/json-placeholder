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

    func getCommentsForPost(_ postId: Int16) async -> Bool {
        do {
            let storagedComments = await CoreDataManager.shared.getComments(postId)
            if storagedComments.isEmpty {
                let serviceResult = try await service.getCommentsFor(postId: "\(postId)")
                switch serviceResult {
                case .success(_):
                    return true
                case .failure(_):
                    return false
                }
            } else {
                return true
            }
        } catch {
            return false
        }
    }
}

// tableview structure
enum PostDetailContext {
    case `default`

    var sections: [PostDetailSection] {
        return [.postDetails, .authorDetails, .comments]
    }
}

enum PostDetailSection {
    case postDetails
    case authorDetails
    case comments

    var title: String {
        switch self {
        case .postDetails:
            return "Post Details".localized
        case .authorDetails:
            return "Author Details".localized
        case .comments:
            return "Comments".localized
        }
    }

    var rows: [PostDetailRow] {
        switch self {
        case .postDetails:
            return [.postTitle, .postBody]
        case .authorDetails:
            return [.authorId]
        case .comments:
            return []
        }
    }
}

enum PostDetailRow {
    case postTitle
    case postBody
    case authorId
}
