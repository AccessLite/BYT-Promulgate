//
//  FoaasViewController.swift
//  BYT-Promulgate
//
//  Created by Eric Chang on 11/27/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import UIKit

class FoaasViewController: UIViewController {

    // MARK: - Properties
    // MARK: - Properties
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var subtitleTextLabel: UILabel!

    var url = URL(string: "http://www.foaas.com/awesome/louis")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        FoaasAPIManager.getFoaas(url: url!) { (foass: Foaas?) in
            DispatchQueue.main.async {
                self.mainTextLabel.text = foass?.message
                self.subtitleTextLabel.text = foass?.subtitle
            }
        }
    }

    // MARK: - Navigation
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
 

}
