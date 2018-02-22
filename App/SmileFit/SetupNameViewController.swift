//
//  SetupNameViewController.swift
//  SmileFit
//
//  Created by Judith Sirera Pulido on 2/2/18.
//  Copyright © 2018 Judith Sirera Pulido. All rights reserved.
//

import UIKit

class SetupNameViewController: ParentViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var txt_name: UITextField!
    
    //MARK: Screen activity
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_name.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        User.sharedUser.name = textField.text!
    }
    
    //MARK: TextField Events
    @IBAction func textFieldDidChange(_ sender: Any) {
        User.sharedUser.name = txt_name.text!
    }
    
}
