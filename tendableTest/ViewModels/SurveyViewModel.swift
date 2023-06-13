//
//  SurveyViewModel.swift
//  tendableTest
//
//  Created by Kiran Babu Davis on 09/06/23.
//

import Foundation
import SwiftUI
import Combine

class SurveyViewModel: ObservableObject {
    
    @Published var inspections: Inspections?
    @Published var gotInspection: Bool = false
    
    var cancellable: AnyCancellable?
    
    init(){
        fetchinspections()
    }
     
    func fetchinspections() {
        let service = SurveyService(networkRequest: NativeRequestable(), environment: .development)
        cancellable = service.getInspections().sink { (completion) in
            switch completion {
            case .failure(let error):
                debugPrint("error = \(error.localizedDescription)")
            case .finished:break
            }
        } receiveValue: { (response) in
            debugPrint("response = \(response)")
            DispatchQueue.main.async {
                self.inspections = response
            }
        }
    }
    
    func categoryIndex(for category: Categories) -> Int {
//        guard let index = inspections?.inspection?.survey?.categories?.firstIndex(where: { $0.id == category.id }) else {
//            fatalError("Category not found")
//        }
        return 0
    }
    func questionIndex(for question: Questions) -> Int {
//        if let categories = inspections?.inspection?.survey?.categories {
//            guard let categoryIndex = categories.firstIndex(where: {
//                if (($0.questions?.contains( question)) != nil)
//
//            }) else {
//                fatalError("Question not found")
//            }
//            guard let index = inspections?.inspection?.survey?.categories[categoryIndex].questions.firstIndex(where: { $0.id == question.id }) else {
//                fatalError("Question not found")
//            }
//            return index
//        }return
        return 0
    }
}
