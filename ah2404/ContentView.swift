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
 
//    @FirestoreQuery(collectionPath: "vehicles", predicates: []) var vehicles: [Vehicle]
    
//    @Binding var loggedIn: Bool

    var body: some View {
        Group {
            if CVModel.userSession != nil {
                MainInterfaceView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            CVModel.vehicleSubscribe()
        }
    }
}

struct AltContentView:View {
    var body: some View {

//        let items:[ItemRow] = [ItemRow(item: MenuItem(id: UUID(), name: "option1"))]
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            NavigationStack {
                List {
                    NavigationLink("Work Folder") {
                        VehicleContentView()
                    }
                    NavigationLink("Work Folder") {
                        VehicleContentView()
                    }
                }
                .navigationTitle("Albers HH 2404")
            }
        }
        .padding()
/*
                Button("SignOut", action: {
                    try! Auth.auth().signOut()
                    loggedIn = false
                    }
                )
*/
    }

}
//struct MenuSection: Codable, Identifiable {
//    var id: UUID
//    var name: String
//    var items: [MenuItem]
//}

struct MenuItem: Codable, Hashable, Identifiable {
    var id: UUID
    var name: String
//    var photoCredit: String
//    var price: Int
//    var restrictions: [String]
//    var description: String
//
//    var mainImage: String {
//        name.replacingOccurrences(of: " ", with: "-").lowercased()
//    }
//
//    var thumbnailImage: String {
//        "\(mainImage)-thumb"
//    }
}

struct ItemRow : View {
    let item: MenuItem

    var body: some View {
        Text(item.name)
    }
}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
