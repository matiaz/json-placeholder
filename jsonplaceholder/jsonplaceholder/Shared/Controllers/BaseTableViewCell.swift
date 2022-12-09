//
//  BaseTableViewCell.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 6/12/22.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: String(describing: self), bundle: nil) }
}
