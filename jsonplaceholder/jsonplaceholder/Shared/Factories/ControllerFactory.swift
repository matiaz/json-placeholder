//
//  ControllerFactory.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 6/12/22.
//

import UIKit

final class ControllerFactory {
    static var home: HomeViewController {
        return UIStoryboard.home.instantiateViewController(withIdentifier: HomeViewController.identifier) as! HomeViewController
    }

    static var postDetails: PostDetailsViewController {
        return UIStoryboard.postDetails.instantiateViewController(withIdentifier: PostDetailsViewController.identifier) as! PostDetailsViewController
    }
}

extension UIStoryboard {
    static var home: UIStoryboard { return UIStoryboard(name: "Home", bundle: nil) }
    static var postDetails: UIStoryboard { return UIStoryboard(name: "PostDetails", bundle: nil) }
}
