//
//  FoaasPreviewViewController.swift
//  BYT-Promulgate
//
//  Created by Eric Chang on 11/27/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import UIKit

class FoaasPreviewViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var previewTextLabel: UILabel!
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var textFieldOne: UITextField!
    @IBOutlet weak var textFieldTwo: UITextField!
    @IBOutlet weak var textFieldThree: UITextField!
    
    
    var fThisOperation: FoaasOperation?
    
    var endPoint: String {
        return fThisOperation?.url ?? ""
    }
    var url: URL {
        return URL(string: "https://www.foaas.com\(endPoint)")!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textFieldOne.delegate = self
        self.textFieldTwo.delegate = self
        self.textFieldThree.delegate = self
        getData(url: url)
        setUpFields()
    }

    func getData(url: URL) {
        FoaasAPIManager.getFoaas(url: url) { (foaas: Foaas?) in
            DispatchQueue.main.async {
                self.previewTextLabel.text = foaas?.description
                self.reloadInputViews()
            }
        }
    }

    func setUpFields() {
        switch (fThisOperation?.fields.count)! {
        case 1:
            labelOne.text = fThisOperation?.fields[0].name
            labelTwo.isHidden = true
            labelThree.isHidden = true
            textFieldTwo.isHidden = true
            textFieldThree.isHidden = true
        case 2:
            labelOne.text = fThisOperation?.fields[0].name
            labelTwo.text = fThisOperation?.fields[1].name
            labelThree.isHidden = true
            textFieldThree.isHidden = true
        case 3:
            labelOne.text = fThisOperation?.fields[0].name
            labelOne.text = fThisOperation?.fields[1].name
            labelOne.text = fThisOperation?.fields[2].name
        default:
            labelOne.isHidden = true
            labelTwo.isHidden = true
            labelThree.isHidden = true
            textFieldOne.isHidden = true
            textFieldTwo.isHidden = true
            textFieldThree.isHidden = true
        }
    }
    
    func updateTextFields (_ textField: UITextField) {
        guard let urlEndPoint = fThisOperation?.url else { return }
        switch textField {
        case textFieldOne:
            let url = urlEndPoint.replacingOccurrences(of: ":\(labelOne.text)", with: textFieldOne.text!)
            let newURL = URL(string: "https://www.foaas.com\(url)")!
            getData(url: newURL)
        case textFieldTwo:
            let url = urlEndPoint.replacingOccurrences(of: ":\(labelTwo.text)", with: textFieldTwo.text!)
            let newURL = URL(string: "https://www.foaas.com\(url)")!
            getData(url: newURL)
        case textFieldThree:
            let url = urlEndPoint.replacingOccurrences(of: ":\(labelThree.text)", with: textFieldThree.text!)
            let newURL = URL(string: "https://www.foaas.com\(url)")!
            getData(url: newURL)
        default:
            print("Text Field Delegation Error")
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        updateTextFields(textField)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateTextFields(textField)
        return true
    }
}
