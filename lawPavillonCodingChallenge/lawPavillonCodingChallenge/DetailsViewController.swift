//
//  DetailsViewController.swift
//  lawPavillonCodingChallenge
//
//  Created by Kuppylee on 03/02/2023.
//

import Foundation
import UIKit
import Kingfisher

class DetailsViewController : UIViewController {
    var avartarUrl : String = ""
    var username : String = ""
    var userType : String = ""
    @IBOutlet weak var userFullImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userTypeLabel: UILabel!
    
    
    override func viewDidLoad() {
        displayDetails()
    }
    
    func displayDetails(){
        userFullImageView.kf.setImage(with: URL(string: "\(avartarUrl)"))
        usernameLabel.text = username
        userTypeLabel.text = userType
    }
}
