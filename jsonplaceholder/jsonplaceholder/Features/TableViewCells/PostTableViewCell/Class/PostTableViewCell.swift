//
//  PostTableViewCell.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: String(describing: self), bundle: nil) }

    // user interface
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postFavoriteImageView: UIImageView!

    // properties
    var viewModel: PostTableViewCellViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setup() {
        accessoryType = .disclosureIndicator
        postTitleLabel.text = viewModel?.currentPost?.title
        postFavoriteImageView.isHidden = true
    }
}
