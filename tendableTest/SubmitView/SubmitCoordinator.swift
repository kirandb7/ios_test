//
//  SubmitCoordinator.swift
//  tendableTest
//
//  Created by Kiran Babu Davis on 06/06/2023.
//

import Foundation
import SwiftUI


class SubmitCoordinator: ObservableObject {
    @Published var isSubmitSuccessful = false

    func submitInspection() {
        isSubmitSuccessful = true
    }
}
