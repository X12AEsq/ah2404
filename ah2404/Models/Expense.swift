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
    var expdate:String
    
    init() {
        self.id = ""
        self.expdate = ""
    }
    
    init (fsid:String, expdate:String) {
        self.id = fsid
        self.expdate = expdate
    }
}
