//
//  CommonViewModel.swift
//  ah2404
//
//  Created by Morris Albers on 2/18/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class CommonViewModel: ObservableObject {
    
    private let db = Firestore.firestore()

    let auth = Auth.auth()
   
    @Published var taskCompleted = false
    
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        userSession = auth.currentUser
    }

    @MainActor
    func createUser(withEmail email: String, password: String) async {
        do {
            let authDataResult = try await auth.createUser(withEmail: email, password: password)
            userSession = authDataResult.user
            print("Debug: User created successfully")
        } catch {
            print("Debug: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func signIn(withEmail email: String, password: String) async -> Bool {
        do {
            let authDataResult = try await auth.signIn(withEmail: email, password: password)
            userSession = authDataResult.user
            print("Debug: User signed in successfully")
            return true
        } catch {
            print("Debug: Failed to sign in user with error \(error.localizedDescription)")
            return false
        }
    }

    @MainActor
    func signout() -> Bool {
        do {
            try auth.signOut()
            userSession = nil
            print("Debug: User signed out successfully")
            return true
        } catch {
            print("Debug: Failed to sign out user with error \(error.localizedDescription)")
            return false
        }
    }

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
/*
    @MainActor
    func addExpense(expenseData: [String:Any]) async {
        
        taskCompleted = false

        do {
            try await db.collection("vehicles").document().setData(expenseData)
            taskCompleted = true
            print("Debug addExpense added successfully")

        } catch {
            print("Debug addExpense failed \(error.localizedDescription)")
        }
    }
*/
    func addExpense(expenseData: [String:Any]) {
        print("in addExpense")
    }

}
