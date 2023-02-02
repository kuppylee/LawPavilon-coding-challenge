//
//  ViewController.swift
//  lawPavillonCodingChallenge
//
//  Created by Kuppylee on 01/02/2023.
//

import UIKit

class SearchViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
   
    

    @IBOutlet weak var searchUserTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var searchResultDescription: UILabel!
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchResultTableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as! SearchResultTableViewCell
        cell.userAvartar = UIImageView(image: UIImage(named: "profilePicture"))
        cell.username.text = "Kuppylee"
        cell.userType.text = "User"
        return cell
    }
    
    


}

class SearchResultTableViewCell : UITableViewCell{
    
    @IBOutlet weak var userType: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userAvartar: UIImageView!
}
