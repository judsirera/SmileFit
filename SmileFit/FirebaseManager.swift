//
//  FirebaseManager.swift
//  SmileFit
//
//  Created by Judith Sirera Pulido on 1/29/18.
//  Copyright © 2018 Judith Sirera Pulido. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseManager {
    static let USERS_PATH: String = "users"
    static let SMILES_PATH: String = "smiles"
    static let DATE_PATH: String = "date"
    static let COLOR_PATH: String = "color"
    static let NAME_PATH: String = "name"
    
    static func initApp() {
        FirebaseApp.configure();
        self.getAllSmilesFromDatabase()
    }
    
    static func saveSmileToDatabase(userId: String, newSmile: ([String: String], [String: [String: Int]])) {
        let ref: DatabaseReference! = Database.database().reference()

        let id = newSmile.0[Smile.ID]!
        ref.child(self.USERS_PATH).child(userId).child(self.SMILES_PATH).child(id).setValue([Smile.TYPE: newSmile.0[Smile.TYPE]])
        ref.child(self.USERS_PATH).child(userId).child(self.SMILES_PATH).child(id).child(self.DATE_PATH).setValue(newSmile.1[Smile.DATE])
    }
    
    static func saveUserToDatabase(userId: String, name: String, color: String) {
        let ref: DatabaseReference! = Database.database().reference()
        
        ref.child(self.USERS_PATH).child(userId).setValue([COLOR_PATH: color, NAME_PATH: name])
    }
    
    static func getAllSmilesFromDatabase() {
        let ref: DatabaseReference! = Database.database().reference()
        
        ref.child(self.USERS_PATH).child(User.sharedUser.id).child(self.SMILES_PATH).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            for key in (value?.allKeys)! {
                //Get ID
                let smileID = key as! String
                
                //Read Smile
                let smileData = value?[key] as? NSDictionary
                
                //Get Type and Date
                let smileType = smileData?[Smile.TYPE] as! String
                let smileDate = smileData?[Smile.DATE] as? NSDictionary
                
                //Get date
                let smileYear = smileDate?[DateManager.YEAR_] as! Int
                let smileMonth = smileDate?[DateManager.MONTH_] as! Int
                let smileDay = smileDate?[DateManager.DAY_] as! Int
                let smileHour = smileDate?[DateManager.HOUR_] as! Int
                let smileMinute = smileDate?[DateManager.MINUTE_] as! Int
                let smileSecond = smileDate?[DateManager.SECOND_] as! Int
                
                //Create smile
                let smile = Smile(type: Int(smileType)!,
                                  date: DateManager.getFirebaseFormat(arrayDate: [smileYear, smileMonth, smileDay, smileHour, smileMinute, smileSecond]),
                                  id: smileID)
                
                User.sharedUser.addSmile(toAdd: smile)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    private init() {}
}

