//
//  PostTableViewCell.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // user interface
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postFavoriteImageView: UIImageView!

    // properties
    var viewModel: PostTableViewCellViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setup() {
        postTitleLabel.text = viewModel?.currentPost?.title
        postFavoriteImageView.isHidden = true
    }
}
