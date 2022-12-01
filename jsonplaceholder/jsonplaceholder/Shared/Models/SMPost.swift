//
//  SMPost.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import Foundation

// the service model object for the posts
struct SMPost: Codable {
    var userID, id: Int?
    var title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
