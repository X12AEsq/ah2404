//
//  Expense.swift
//  ah2404
//
//  Created by Morris Albers on 2/20/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class Expense: Identifiable, Codable, ObservableObject {
    
    @DocumentID var id: String?
    var vehicle:String
    var expdate:String
    
    init() {
        self.id = ""
        self.vehicle = ""
        self.expdate = ""
    }
    
    init (fsid:String, expdate:String, vehicle:String) {
        self.id = fsid
        self.vehicle = vehicle
        self.expdate = expdate
    }
}
