//
//  SelectVehicleView.swift
//  ah2404
//
//  Created by Morris Albers on 2/20/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

@available(iOS 15.0, *)
struct SelectVehicleView: View {
    @EnvironmentObject var CVModel:CommonViewModel
 
    @FirestoreQuery(collectionPath: "vehicles", predicates: []) var vehicles: [Vehicle]

    var body: some View {
        NavigationView {
            List {
                ForEach(vehicles) { vehicle in
                    NavigationLink {
//                        EditVehicleView(vehicle: vehicle)
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
            }
            .listStyle(.plain)
            .navigationTitle("Which Vehicle?").fontWeight(.regular)
        }
    }
}

//struct SelectVehicleView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectVehicleView()
//    }
//}
