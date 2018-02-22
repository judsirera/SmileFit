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
    static let ID = "ID"
    static let NAME = "NAME"
    
    //MAKE: Properties
    static let sharedUser = User();
    
    var smiles: [Smile]
    var id: String
    var name: String
    var color: String
    
    private init() {
        self.id = UIDevice.current.identifierForVendor!.uuidString
        self.smiles = []
        
        if (!User.doesUserExist()) {
            self.color = ColorManager.SCREEN_DEFAULT
            self.name = UIDevice.current.name
            
        } else {
            self.color = UserDefaults.standard.string(forKey: User.COLOR)!
            self.name = UserDefaults.standard.string(forKey: User.NAME)!
        }
    }
    
    func addSmile(toAdd: Smile) {
        self.smiles.append(toAdd)
    }
    
    func updateColor(newColor: String) {
        self.color = newColor
        self.saveUser()
    }
    
    func updateName(newName: String) {
        self.name = newName
        self.saveUser()
    }
    
    func saveUser() {
        UserDefaults.standard.set(self.id, forKey: User.ID)
        UserDefaults.standard.set(self.name, forKey: User.NAME)
        UserDefaults.standard.set(self.color, forKey: User.COLOR)
    }
    
    func getUser() {
        self.color = UserDefaults.standard.string(forKey: User.COLOR)!
        self.name = UserDefaults.standard.string(forKey: User.NAME)!
    }
    
    func saveNumOfSmiles() {
        if (self.smiles.count > 0) {
            UserDefaults.standard.set(self.smiles.count, forKey: User.NUM_OF_SMILES)
        }
    }
    
    func getNumOfSmiles() -> Int {
        return UserDefaults.standard.integer(forKey: User.NUM_OF_SMILES)
    }
    
    static func doesUserExist() -> Bool {
        return UserDefaults.standard.string(forKey: User.ID) != nil
    }
}
