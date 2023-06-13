//
//  tendableTestApp.swift
//  tendableTest
//
//  Created by Kiran Babu Davis on 08/06/23.
//

import SwiftUI


@main
struct TendableTestApp: App {
    @StateObject var userAuth = UserAuth()
    @StateObject var inspectionCoordinator = InspectionCoordinator()
    @StateObject var inspectionViewModel = InspectionViewModel()

    var body: some Scene {
        WindowGroup {
            InspectionView()
                           .environmentObject(userAuth)
                           .environmentObject(inspectionCoordinator)
                           .environmentObject(inspectionViewModel)
            
           // LoginView().environmentObject(userAuth)
        }
    }
}




