//
//  InspectionCoordinator.swift
//  tendableTest
//
//  Created by Kiran Babu Davis on 06/06/2023.
//

import Foundation
import SwiftUI


class InspectionCoordinator: ObservableObject {
    @Published var isSubmitViewPresented = false
    @Published var showingSubmitView = false

    func showSubmitView() {
        showingSubmitView = true
    }

    func dismissSubmitView() {
        isSubmitViewPresented = false
    }
}
