//
//  CommonViewModel.swift
//  ah2404
//
//  Created by Morris Albers on 2/18/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class CommonViewModel: ObservableObject {
    @Published var vehicles = [Vehicle]()
    
    var db = Firestore.firestore()

}
