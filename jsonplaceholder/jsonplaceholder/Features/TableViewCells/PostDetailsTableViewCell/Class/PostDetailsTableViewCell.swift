//
//  PostDetailsTableViewCell.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import UIKit

class PostDetailsTableViewCell: BaseTableViewCell {

    // user interface
    @IBOutlet weak var postDetailLabel: UILabel!

    // properties
    var viewModel: PostDetailsTableViewCellViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setup() {
        selectionStyle = .none
    }

    func configureCell(_ viewModel: PostDetailsTableViewCellViewModel) {
        self.viewModel = viewModel
        switch viewModel.currentRow {
        case .authorId:
            postDetailLabel.text = "Author Id: ".localized + "\(viewModel.currentPost?.userId ?? -1)"
        case .postTitle:
            postDetailLabel.text = "Title: ".localized + (viewModel.currentPost?.title ?? "")
        case .postBody:
            postDetailLabel.text = "Body: ".localized + (viewModel.currentPost?.body ?? "")
        default:
            postDetailLabel.text = viewModel.currentComment?.body
        }
    }
}
