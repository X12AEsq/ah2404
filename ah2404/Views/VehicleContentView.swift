//
//  VehicleContentView.swift
//  ah2404
//
//  Created by Morris Albers on 2/20/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

@available(iOS 15.0, *)
struct VehicleContentView: View {
    @State private var showingEditVehicleView = false
    
    @EnvironmentObject var CVModel:CommonViewModel
 
    @FirestoreQuery(collectionPath: "vehicles", predicates: []) var vehicles: [Vehicle]
    
//    @Binding var loggedIn: Bool

    var body: some View {
        // TODO: Replace with navigation stack
        NavigationView {
            List {
                ForEach(vehicles) { vehicle in
                    NavigationLink {
                        EditVehicleView(vehicle: vehicle)
                    } label: {
                        HStack(alignment:.center) {
                            VStack(alignment:.leading) {
                                Text(vehicle.nickname)
                                    .font(.headline)
                                Text(vehicle.model)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .onDelete(perform: delete)
                NavigationLink(destination: { Text("xxx") }, label: { Text("yyy") })
            }
            .listStyle(.plain)
            .navigationTitle("Albers HH 2404").fontWeight(.regular)
            .sheet(isPresented: $showingEditVehicleView) {
                EditVehicleView()
            }
/*
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingEditVehicleView = true
                    } label: {
                        Image(systemName: "plus")
                            .padding(8)
                            .background(.yellow)
                            .foregroundColor(.black)
                            .clipShape(Circle())
                    }
                }
            }
*/
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let vehicle = vehicles[index]
            Task {
                await CVModel.deleteVehicle(vehicle:vehicle)
            }
        }
    }
}
