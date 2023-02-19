//
//  VehicleView.swift
//  ah2404
//
//  Created by Morris Albers on 2/18/23.
//

import SwiftUI

struct VehicleView: View {
    
    @State private var nickname = ""
    @State private var make = ""
    @State private var model = ""
    @State private var year = 0
    
    @Environment(\.dismiss) var dismiss

    var vehicle:Vehicle?
    
    var vehicleHeading: String {
        if let _ = vehicle {
            return "Edit Vehicle"
        } else {
            return "Add Vehicle"
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(vehicleHeading)
                    .font(.largeTitle.bold())
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(.yellow)
                        .foregroundColor(.black)
                        .clipShape(Circle())
                }
            }
            .padding(.vertical, 30)
        }
        
        Spacer()
        
        VStack(spacing: 20) {
            VStack(alignment:.leading) {
                Text("nickname:")
                    .foregroundColor(.green)
                    .opacity(0.6)
                TextField("Enter nickname", text: $nickname)
                    .textFieldStyle(.roundedBorder)
            }
            VStack(alignment:.leading) {
                Text("make:")
                    .foregroundColor(.green)
                    .opacity(0.6)
                TextField("Enter make", text: $nickname)
                    .textFieldStyle(.roundedBorder)
            }
            VStack(alignment:.leading) {
                Text("model:")
                    .foregroundColor(.green)
                    .opacity(0.6)
                TextField("Enter model", text: $nickname)
                    .textFieldStyle(.roundedBorder)
            }
            VStack(alignment:.leading) {
                Text("year:")
                    .foregroundColor(.green)
                    .opacity(0.6)
                TextField("Enter year", value: $year, format: .number)
                    .textFieldStyle(.roundedBorder)
            }
        
            Spacer()
            
            Button {
                EditData()
            } label: {
                Text(vehicleHeading)
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: 55)
                    .background(.yellow)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .onAppear {
            if let vehicle = vehicle {
                nickname = vehicle.nickname
                make = vehicle.make
                model = vehicle.model
                year = vehicle.year
            }
        }
    }
    
    func EditData() {
        let vehicleData: [String:Any] = [
            "nickname":nickname,
            "make":make,
            "model":model,
            "year":year
        ]
    }
}

struct VehicleView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleView()
    }
}
