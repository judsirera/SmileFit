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
    static let DATES_PATH: String = "date"
    
    static func initApp() {
        FirebaseApp.configure();
        self.getAllSmilesFromDatabase()
    }
    
    static func saveToDatabase(toAdd: ([String: String], [String: [String: Int]])) {
        let ref: DatabaseReference! = Database.database().reference()

        let id = toAdd.0[Smile.ID_]!
        ref.child(self.USERS_PATH).child(User.sharedUser.id).child(self.SMILES_PATH).child(id).setValue([Smile.TYPE_: toAdd.0[Smile.TYPE_]])
        ref.child(self.USERS_PATH).child(User.sharedUser.id).child(self.SMILES_PATH).child(id).child(self.DATES_PATH).setValue(toAdd.1[Smile.DATE_])
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
                let smileType = smileData?[Smile.TYPE_] as! String
                let smileDate = smileData?[Smile.DATE_] as? NSDictionary
                
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

