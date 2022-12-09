//
//  PostDetailsTableViewCell.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import UIKit

class PostDetailsTableViewCell: BaseTableViewCell {

    // user interface
    @IBOutlet weak var postCommentLabel: UILabel!

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
        postCommentLabel.text = viewModel.currentComment?.body
    }
}
