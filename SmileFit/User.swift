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
    static let COLOR = "COLOR"
    
    //MAKE: Properties
    static let sharedUser = User();
    
    var smiles: [Smile]
    var id: String
    var name: String
    var color: String
    
    private init() {
        self.id = UIDevice.current.identifierForVendor!.uuidString
        self.smiles = []
        self.name = UIDevice.current.name
        
        if (UserDefaults.standard.string(forKey: User.COLOR) == nil) {
            self.color = ColorManager.SCREEN_DEFAULT
            UserDefaults.standard.set(self.color, forKey: User.COLOR)
        } else {
            self.color = UserDefaults.standard.string(forKey: User.COLOR)!
        }
    }
    
    func addSmile(toAdd: Smile) {
        self.smiles.append(toAdd)
        self.saveNumOfSmiles()
    }
    
    func saveColor(newColor: String) {
        self.color = newColor
        UserDefaults.standard.set(newColor, forKey: User.COLOR)
    }
    
    func saveNumOfSmiles() {
        if (User.sharedUser.smiles.count > 0) {
            UserDefaults.standard.set(User.sharedUser.smiles.count, forKey: User.NUM_OF_SMILES)
        }
    }
}
