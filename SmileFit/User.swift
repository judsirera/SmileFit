//
//  User.swift
//  SmileFit
//
//  Created by Judith Sirera Pulido on 1/29/18.
//  Copyright © 2018 Judith Sirera Pulido. All rights reserved.
//

import Foundation
import UIKit

class User {
    //MAKE: Constants
    static let NUM_OF_SMILES = "NUM_OF_SMILES"
    
    //MAKE: Properties
    static let sharedUser = User();
    
    var smiles: [Smile]
    var id: String
    
    private init() {
        self.id = UIDevice.current.identifierForVendor!.uuidString
        self.smiles = []
    }
    
    func addSmile(toAdd: Smile) {
        self.smiles.append(toAdd)
        self.saveData()
    }
    
    func saveData() {
        if (User.sharedUser.smiles.count > 0) {
            UserDefaults.standard.set(User.sharedUser.smiles.count, forKey: User.NUM_OF_SMILES)
        }
    }
}
