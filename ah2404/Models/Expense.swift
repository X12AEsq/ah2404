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
    var expmiles: String
    var exptype:String
    var expamount:String
    var expdescr:String
    
    init() {
        self.id = ""
        self.vehicle = ""
        self.expdate = ""
        self.exptype = ""
        self.expamount = ""
        self.expmiles = ""
        self.expdescr = ""
    }
    
    init (fsid:String, expdate:String, vehicle:String, exptype:String, amount:String, miles:String, descr:String) {
        self.id = fsid
        self.vehicle = vehicle
        self.expdate = expdate
        self.exptype = exptype
        self.expamount = amount
        self.expmiles = miles
        self.expdescr = descr
    }
}
