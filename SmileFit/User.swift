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
    private var color: UIColor
    
    private init() {
        self.id = UIDevice.current.identifierForVendor!.uuidString
        self.smiles = []
        self.color = UIColor(named: "Purple")!
    }
    
    func addSmile(toAdd: Smile) {
        self.smiles.append(toAdd)
        self.saveNumOfSmiles()
    }
    
    func getColor() -> UIColor {
        return self.color
    }
    
    func saveColor(newColor: UIColor) {
        self.color = newColor
        //TODO: is not working -> save color
        UserDefaults.standard.setValue(newColor as Any, forKey: User.COLOR)
    }
    
    func saveNumOfSmiles() {
        if (User.sharedUser.smiles.count > 0) {
            UserDefaults.standard.set(User.sharedUser.smiles.count, forKey: User.NUM_OF_SMILES)
        }
    }
}
