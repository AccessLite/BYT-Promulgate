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
        setUpFields(url: url)
    }
    
    func getData(url: URL) {
        FoaasAPIManager.getFoaas(url: url) { (foaas: Foaas?) in
            DispatchQueue.main.async {
                self.reloadInputViews()
            }
        }
    }
    
    func setUpFields(url: URL) {
        FoaasAPIManager.getFoaas(url: url, completion: { (foass: Foaas?) in
            DispatchQueue.main.async {
                guard let fields = self.fThisOperation?.fields else { return }
                self.previewTextLabel.text = foass?.description
                switch (fields.count) {
                case 1:
                    self.labelOne.text = fields[0].name
                    self.labelTwo.isHidden = true
                    self.labelThree.isHidden = true
                    self.textFieldTwo.isHidden = true
                    self.textFieldThree.isHidden = true
                case 2:
                    self.labelOne.text = fields[0].name
                    self.labelTwo.text = fields[1].name
                    self.labelThree.isHidden = true
                    self.textFieldThree.isHidden = true
                case 3:
                    self.labelOne.text = fields[0].name
                    self.labelOne.text = fields[1].name
                    self.labelOne.text = fields[2].name
                default:
                    self.labelOne.isHidden = true
                    self.labelTwo.isHidden = true
                    self.labelThree.isHidden = true
                    self.textFieldOne.isHidden = true
                    self.textFieldTwo.isHidden = true
                    self.textFieldThree.isHidden = true
                }
            }
        })
    }
    
    func updateTextFields (_ textField: UITextField) {
        guard let urlEndPoint = fThisOperation?.url else { return }
        switch textField {
        case textFieldOne:
            let url = urlEndPoint.replacingOccurrences(of: ":\(labelOne.text!.lowercased())", with: textFieldOne.text!)
            self.fThisOperation?.url = url
        case textFieldTwo:
            let url = urlEndPoint.replacingOccurrences(of: ":\(labelTwo.text!.lowercased())", with: textFieldTwo.text!)
            self.fThisOperation?.url = url
        case textFieldThree:
            let url = urlEndPoint.replacingOccurrences(of: ":\(labelThree.text!.lowercased())", with: textFieldThree.text!)
            self.fThisOperation?.url = url
        default:
            print("Text Field Delegation Error")
        }
        let newURL = url
        setUpFields(url: newURL)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        updateTextFields(textField)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateTextFields(textField)
        return true
    }
}
