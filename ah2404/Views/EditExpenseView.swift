//
//  EditExpenseView.swift
//  ah2404
//
//  Created by Morris Albers on 2/20/23.
//

import SwiftUI

struct EditExpenseView: View {
    var vehicle:Vehicle
    var expense:Expense?
    
    let expTypes = ExpenseCategories()
    
//    let integerFormatter: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        return formatter
//    }()
    
    @State var expenseIntDate:Date = Date()
    @State var expenseDate:[String] = ["", "", ""]
    @State var expenseDateYear:String = ""
    @State var expenseDateMonth:String = ""
    @State var expenseDateDay:String = ""
    @State var expenseDateString:String = ""
    @State var expenseTimeString:String = ""

    @State private var editing:Bool = false
    @State private var saveMessage = ""
    @State private var expenseHeading = ""
    @State private var editMessage = ""
    @State private var expenseType = ""
    @State private var expdate = ""
    @State private var expvehicle = ""
    @State private var expamount = "" // fuel in gallons
    @State private var expmiles = ""
    @State private var expdescr = ""
    @State private var expcost = ""

    var body: some View {
        VStack(alignment:.leading) {
            VStack(alignment:.leading) {
                Text(expenseHeading)
                    .font(.largeTitle.bold())
                HStack {
                    Text("for:")
                    Text(vehicle.formattedVehicle)
                }
                if editMessage != "" {
                    Text(editMessage)
                        .foregroundColor(.red)
                }
            }
            VStack(alignment:.leading) {
                HStack {
                    Text("Expense Date")
                    DatePicker("XX", selection: $expenseIntDate).padding().onChange(of: expenseIntDate, perform: { value in
                        expenseDateString = DateService.dateExt2Int(inDate: value)
                        populateDates()
                        print("Date: \(expenseDateString) \(expenseTimeString) \(expenseIntDate)")
                    })
                }
                HStack {
                    Text("Expense Type")
                    Picker("Expense Type", selection: $expenseType) {
                        ForEach(expTypes.ExpenseCategoryOptions, id: \.self) {
                            Text($0).tag(Optional($0))
                        }
                    }
                }
                HStack {
                    Text("Expense Miles")
                    TextField(text: $expmiles, prompt: Text("mileage")) {
                        Text(expmiles).tag(Optional<String>(nil))
                    }
                    .onSubmit {
                        let worklist = FormattingService.deComposeNumber(inpnumber:expmiles)
                        expmiles = FormattingService.formatNumber(inpnumber: worklist, decimals: 0)
                    }
                }
            }
            VStack(alignment:.leading) {
                if expenseType == "Fuel" {
                    HStack {
                        Text("Expense Fuel")
                        TextField(text: $expamount, prompt: Text("gallons")) {
                            Text(expamount).tag(Optional<String>(nil))
                        }
                        .onSubmit {
                            print(expamount)
                            let worklist = FormattingService.deComposeNumber(inpnumber:expamount)
                            expamount = FormattingService.formatNumber(inpnumber: worklist, decimals: 3)
                        }
                    }
                }
                HStack {
                    Text("Expense Cost")
                    TextField(text: $expcost, prompt: Text("cost")) {
                        Text(expcost).tag(Optional<String>(nil))
                    }
                    .onSubmit {
                        let worklist = FormattingService.deComposeNumber(inpnumber:expcost)
                        expcost = FormattingService.formatNumber(inpnumber: worklist, decimals: 2)
                    }
                }
                HStack {
                    Text("Expense Description")
                    TextField(text: $expdescr, prompt: Text("description")) {
                        Text(expdescr).tag(Optional<String>(nil))
                    }
                }
                Button {
                    let recordStatus = editExpenseRecord()
                    if recordStatus {
                        EditData()
                        if editing {
                            print("Editing")
                        } else {
                            print("Saving")
                        }
                    }
                } label: {
                    Text(saveMessage)
                        .font(.headline.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 55)
                        .background(.red.opacity(0.3), in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                }
                .buttonStyle(CustomButton())
            }

            Spacer()
        }
        .padding(.leading, 20.0)
        .onAppear {
            if let expense = expense {
                expdate = expense.expdate
//                expenseIntDate = DateService.dateExt2Int(inDate: expdate)
                expenseHeading = "Edit Expense"
                expenseType = expense.exptype
                expamount = expense.expamount
                expmiles = expense.expmiles
                expdescr = expense.expdescr
                editing = true
                saveMessage = "Update"
            } else {
                expenseHeading = "New Expense"
                expdate = ""
                expenseIntDate = Date()
                populateDates()
                print("Date: \(expenseDateString) \(expenseTimeString) \(expenseIntDate)")
                expenseType = expTypes.ExpenseCategoryOptions[0]
                expvehicle = vehicle.nickname
                expamount = ""
                expmiles = ""
                expdescr = ""
                editing = false
                saveMessage = "Add"
            }
        }
    }
/*
 (lldb) po expenseData
 ▿ 7 elements
   ▿ 0 : 2 elements
     - key : "vehicle"
     - value : "Sub"
   ▿ 1 : 2 elements
     - key : "expenseMiles"
     - value : ""
   ▿ 2 : 2 elements
     - key : "expenseFuel"
     - value : ""
   ▿ 3 : 2 elements
     - key : "expenseDate"
     - value : "20230222, 2148"
   ▿ 4 : 2 elements
     - key : "expenseType"
     - value : "Fuel"
   ▿ 5 : 2 elements
     - key : "expenseCost"
     - value : ""
   ▿ 6 : 2 elements
     - key : "expenseDescr"
     - value : ""
 
    EditData() has not been invoked yet when editExpenseRecord() is called
*/
    func editExpenseRecord() -> Bool {
        editMessage = ""
        if expenseDateString == "" || expenseTimeString == "" {
            editMessage = "Date " + expenseDateString + ", " + expenseTimeString + " is invalid"
            return false
        } else {
            expdate = expenseDateString + ", " + expenseTimeString
            print(expenseDateString, expenseTimeString, expdate)
        }
        return true
    }
    
    func populateDates() -> Void {
        let workDate:[String] = DateService.splitDateTime(inDate: expenseIntDate)
        expenseDateYear = workDate[0]
        expenseDateMonth = workDate[1]
        expenseDateDay = workDate[2]
        expenseDateString = workDate[7]
        expenseTimeString = workDate[6]
    }
    
    func EditData() {
        let expenseData: [String:Any] = [
            "vehicle":expvehicle,
            "expenseDate":expdate,
            "expenseMiles":expmiles,
            "expenseType":expenseType,
            "expenseFuel":expamount,
            "expenseDescr":expdescr,
            "expenseCost":expcost
        ]
        
        if let expense = expense {
            // Update
            print(expenseData)
            guard let expenseID = expense.id else {
                return
            }
            
//            Task {
//                await CVModel.updateVehicle(vehicleID: vehicleID, vehicleData: vehicleData)
//                if CVModel.taskCompleted {
//                    dismiss()
//                }
//            }
        } else {
            print(expenseData)
            // Add
//            Task {
//                await CVModel.addVehicle(vehicleData: vehicleData)
//                if CVModel.taskCompleted {
//                    dismiss()
//                }
//            }
        }
    }

}

//struct EditExpenseView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditExpenseView()
//    }
//}
