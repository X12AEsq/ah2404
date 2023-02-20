//
//  ah2404App.swift
//  ah2404
//
//  Created by Morris Albers on 2/18/23.
//

import SwiftUI
import FirebaseCore

@available(iOS 15.0, *)

@main
struct ah2404App: App {
    
    @StateObject var CVModel = CommonViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(CVModel)
        }
    }
}
