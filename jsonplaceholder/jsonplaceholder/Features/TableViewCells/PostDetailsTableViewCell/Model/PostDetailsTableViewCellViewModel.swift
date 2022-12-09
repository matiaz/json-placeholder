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

    // custom init in case we need it
    init(comment: CMComment) {
        super.init()
        currentComment = comment
    }
}
