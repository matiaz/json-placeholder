//
//  PostTableViewCell.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import UIKit

class PostTableViewCell: BaseTableViewCell {

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
        selectionStyle = .none
        postFavoriteImageView.isHidden = true
    }

    func configureCell(_ viewModel: PostTableViewCellViewModel) {
        self.viewModel = viewModel
        postTitleLabel.text = viewModel.currentPost?.title   
    }

    func toggleFavoriteIcon() {
        postFavoriteImageView.isHidden.toggle()
    }
}
