//
//  MainInterfaceView.swift
//  ah2404
//
//  Created by Morris Albers on 2/20/23.
//

import SwiftUI

import SwiftUI

struct MainInterfaceView: View {
    
    @EnvironmentObject var commonVM: CommonViewModel
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Button {
//                        contentVM.signout()
                    } label: {
                        Text("sign out")
                            .padding(10)
                            .foregroundColor(.white)
                            .background(.white.opacity(0.3))
                            .clipShape(Capsule())
                    }
                    .padding()
                }
            
                Spacer()
                
                VStack {
                    Text("Welcome Here")
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("Let'g grow together")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.3))
                }
                .padding(.bottom, 60)
                
                Spacer()
                
            }
        }
    }
}

struct MainInterfaceView_Previews: PreviewProvider {
    static var previews: some View {
        MainInterfaceView()
    }
}
