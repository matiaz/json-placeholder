//
//  PostDetailsTableViewCellViewModel.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 7/12/22.
//

import Foundation

class PostDetailsTableViewCellViewModel: NSObject {

    // properties
    var currentComment: CMComment?
    var currentPost: CMPost?
    var currentRow: PostDetailRow?

    // custom init in case we need it
    init(comment: CMComment? = nil, post: CMPost? = nil, row: PostDetailRow? = nil) {
        super.init()
        currentComment = comment
        currentPost = post
        currentRow = row
    }
}
