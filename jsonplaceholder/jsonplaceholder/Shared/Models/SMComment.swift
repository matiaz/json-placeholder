//
//  SMComment.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import Foundation

struct SMComment: Codable {
    var postId, id: Int?
    var name, email, body: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, body, postId
    }
}
