//
//  ViewController.swift
//  SmileFit
//
//  Created by Judith Sirera Pulido on 1/26/18.
//  Copyright © 2018 Judith Sirera Pulido. All rights reserved.
//

import UIKit

class CounterViewController: ParentViewController {
    
    //MARK: Properties
    @IBOutlet weak var lbl_numOfSmiles: UILabel!
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let s: Smile = Smile(type: 0)
        FirebaseManager.saveSmileToDatabase(userId: User.sharedUser.id, newSmile: s.getSmile())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNumOfSmiles()
    }
    
    func setNumOfSmiles() {
        lbl_numOfSmiles.text = String(UserDefaults.standard.integer(forKey: User.NUM_OF_SMILES))
    }

}

