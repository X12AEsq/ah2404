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
    
    private let db = Firestore.firestore()
    
    @Published var taskCompleted = false
    
    @MainActor
    func addVehicle(vehicleData: [String:Any]) async {
        
        taskCompleted = false

        do {
            try await db.collection("vehicles").document().setData(vehicleData)
            taskCompleted = true
            print("Debug addVehicle added successfully")

        } catch {
            print("Debug addVehicle failed \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func updateVehicle(vehicleID:String, vehicleData: [String:Any]) async {
        
        taskCompleted = false

        do {
            try await db.collection("vehicles").document(vehicleID).updateData(vehicleData)
            taskCompleted = true
            print("Debug updateVehicle updated successfully")

        } catch {
            print("Debug updateVehicle failed \(error.localizedDescription)")
        }
    }

    func deleteVehicle(vehicle:Vehicle) async {
        
        taskCompleted = false

        guard let vehicleID = vehicle.id else {
            print("Debug deleteVehicle failed, no vehicle id")
            return
        }
        
        do {
            try await db.collection("vehicles").document(vehicleID).delete()
            taskCompleted = true
            print("Debug deleteVehicle deleted successfully")
        } catch {
            print("Debug deleteVehicle failed \(error.localizedDescription)")
        }
    }

}
