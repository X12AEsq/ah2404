//
//  ContentView.swift
//  ah2404
//
//  Created by Morris Albers on 2/18/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

@available(iOS 15.0, *)
struct ContentView: View {
    @State private var showingEditVehicleView = false
    
    @EnvironmentObject var CVModel:CommonViewModel
 
    @FirestoreQuery(collectionPath: "vehicles", predicates: []) var vehicles: [Vehicle]
    
    @Binding var loggedIn: Bool

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
            }
            .listStyle(.plain)
            .navigationTitle("Albers HH 2404").fontWeight(.regular)
            .sheet(isPresented: $showingEditVehicleView) {
                EditVehicleView()
            }
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
/*
                Button("SignOut", action: {
                    try! Auth.auth().signOut()
                    loggedIn = false
                    }
                )
*/
        }
//        .onAppear() {
//            print("ContentView appears")
//            pcvm.setVersion(version: "2.0.0")
//            initData()
//            print("ContentView appearance complete")
//        }
//        .onDisappear() {
//            // By unsubscribing from the view model, we prevent updates coming in from
//            // Firestore to be reflected in the UI. Since we do want to receive updates
//            // when the user is on any of the child screens, we keep the subscription active!
//            //
//            // print("BooksListView disappears. Unsubscribing from data updates.")
//            // self.viewModel.unsubscribe()
//        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let vehicle = vehicles[index]
            Task {
                await CVModel.deleteVehicle(vehicle:vehicle)
            }
        }
    }
    
    func initData() {
        print("Initializing")
//        pcvm.representationSubscribe()
//        pcvm.appearanceSubscribe()
//        pcvm.causeSubscribe()
//        pcvm.clientSubscribe()
//        pcvm.noteSubscribe()
//        representationCount = pcvm.representations.count
//        print("\(pcvm.representations.count) representations ready")
        print("Initialization complete")
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
