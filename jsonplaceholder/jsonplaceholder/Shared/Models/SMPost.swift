//
//  SMPost.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import Foundation

// the service model object for the posts
struct SMPost: Codable {
    var userId, postId: Int?
    var title, body: String?

    enum CodingKeys: String, CodingKey {
        case postId = "id"
        case title, body, userId
    }
}
