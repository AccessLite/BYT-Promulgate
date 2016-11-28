//
//  FoaasOperationsTableViewController.swift
//  BYT-Promulgate
//
//  Created by Eric Chang on 11/27/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import UIKit

class FoaasOperationsTableViewController: UITableViewController {

    let operations = FoaasDataManager.shared.operations!
    let identifier = "OperationCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FoaasOperationTableViewCell
        
        let operation = operations[indexPath.row]
        cell.operationTitleTextLabel.text = operation.name
        return cell
    }
    
    // MARK: - Navigation
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = (sender as? FoaasOperationTableViewCell).flatMap(tableView.indexPath) {
            (segue.destination as! FoaasPreviewViewController).fThisOperation = operations[indexPath.row]
        }
    }
    
    // MARK: - Actions
    // MARK: - Actions
    @IBAction func dismiss(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

}
