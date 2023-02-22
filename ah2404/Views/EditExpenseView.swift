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
    @State private var expamount = ""
    @State private var expmiles = ""
    @State private var expdescr = ""

    var body: some View {
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
            HStack {
                Text("Expense Date")
                DatePicker("XX", selection: $expenseIntDate).padding().onChange(of: expenseIntDate, perform: { value in
                    expenseDateString = DateService.dateExt2Int(inDate: value)
                    let workDate:[String] = DateService.splitDateTime(inDate: expenseIntDate)
                    expenseDateYear = workDate[0]
                    expenseDateMonth = workDate[1]
                    expenseDateDay = workDate[2]
                    expenseDateString = workDate[7]
                    expenseTimeString = workDate[6]
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
                Text("Expense Description")
                TextField(text: $expdescr, prompt: Text("description")) {
                    Text(expdescr).tag(Optional<String>(nil))
                }
            }
            Button {
                editExpense()
                if editing {
                    print("Editing")
                } else {
                    print("Saving")
                }
            } label: {
                Text(saveMessage)
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 55)
                    .background(.red.opacity(0.3), in: RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
            .buttonStyle(CustomButton())

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
    func editExpense() {
        editMessage = ""
        if expenseDateString == "" || expenseTimeString == "" {
            editMessage = "Date " + expenseDateString + ", " + expenseTimeString " is invalid"
            return
        } else {
            expdate = expenseDateString + ", " + expenseTimeString
        }
    }
}

//struct EditExpenseView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditExpenseView()
//    }
//}
