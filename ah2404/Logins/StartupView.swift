//
//  StartupView.swift
//  ah2404
//
//  Created by Morris Albers on 2/18/23.
//
import SwiftUI
import FirebaseAuth

@available(iOS 15.0, *)
struct StartupView: View {
//    @StateObject var pcvm = PracticeContentViewModel()
    @Binding var loggedIn: Bool

    var body: some View {
        NavigationView {
            VStack (spacing:20) {
                VStack {
//                    Text("pcvm version \(pcvm.practiceversion)")
//                    Text("\(pcvm.representations.count) representations ready")
//                    Text("\(pcvm.appearances.count) appearances ready")
//                    Text("\(pcvm.causes.count) causes ready")
//                    Text("\(pcvm.clients.count) clients ready")
//                    Text("\(pcvm.notes.count) notes ready")
                    Text("Welcome!")
                }
//                NavigationLink(destination: ListAppearancesView().environmentObject(pcvm)) {
//                    Text("Appearances")
//                }
//                NavigationLink(destination: ListClientsView().environmentObject(pcvm)) {
//                    Text("Clients")
//                }
//                NavigationLink(destination: ListCausesView().environmentObject(pcvm)) {
//                    Text("Causes")
//                }
//                NavigationLink(destination: ListRepresentationsView().environmentObject(pcvm)) {
//                    Text("Representations")
//                }
//                NavigationLink(destination: DocumentMenuView().environmentObject(pcvm)) {
//                    Text("Documents")
//                }
                Button("SignOut", action: {
                    try! Auth.auth().signOut()
                    loggedIn = false
                    }
                )
            }
        }
//        .onAppear() {
//            print("ContentView appears")
//            pcvm.setVersion(version: "2.0.0")
//            initData()
//            print("ContentView appearance complete")
//        }
        .onDisappear() {
            // By unsubscribing from the view model, we prevent updates coming in from
            // Firestore to be reflected in the UI. Since we do want to receive updates
            // when the user is on any of the child screens, we keep the subscription active!
            //
            // print("BooksListView disappears. Unsubscribing from data updates.")
            // self.viewModel.unsubscribe()
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
