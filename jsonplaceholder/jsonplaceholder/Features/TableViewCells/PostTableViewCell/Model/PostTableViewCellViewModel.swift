//
//  PostTableViewCellViewModel.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import Foundation

class PostTableViewCellViewModel: NSObject {

    var currentPost: SMPost?

    // custom init in case we need it
    init(post: SMPost) {
        super.init()
        currentPost = post
    }
}
