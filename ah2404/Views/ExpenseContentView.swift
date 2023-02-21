//
//  ExpenseContentView.swift
//  ah2404
//
//  Created by Morris Albers on 2/20/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

@available(iOS 15.0, *)
struct ExpenseContentView: View {
    var vehicle:Vehicle
    
    @State private var showingEditVehicleView = false
    
    @EnvironmentObject var CVModel:CommonViewModel
 
    @FirestoreQuery(collectionPath: "expenses", predicates: [.order(by: "expdate")]) var expenses: [Expense]

    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses) { expense in
                    if expense.vehicle == vehicle.nickname {
                        NavigationLink {
                            EditExpenseView(vehicle: vehicle, expense: expense)
                        } label: {
                            HStack(alignment:.center) {
                                VStack(alignment:.leading) {
                                    Text(expense.expdate)
                                        .font(.headline)
                                }
                            }
                        }
                    }
                }
                .listStyle(.plain)
                NavigationLink(destination: { EditExpenseView(vehicle: vehicle) }, label: { Text("New Expense") })
            }
            .navigationTitle("Expense?").fontWeight(.regular)
        }
    }
}

//struct ExpenseContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExpenseContentView()
//    }
//}
