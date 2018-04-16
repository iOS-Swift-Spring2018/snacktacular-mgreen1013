//
//  Spots.swift
//  Snacktacular
//
//  Created by Michael Green on 4/10/18.
//  Copyright © 2018 John Gallaugher. All rights reserved.
//

import Foundation
import Firebase


class Spots {
    var spotArray = [Spot]()
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping() -> ()) {
        db.collection("spots").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                return completed()
            }
            self.spotArray = []
            for document in querySnapshot!.documents {
                let spot = Spot(dictionary: document.data())
                spot.documentID = document.documentID
                self.spotArray.append(spot)
            }
            completed()
        }
        
    }
}

