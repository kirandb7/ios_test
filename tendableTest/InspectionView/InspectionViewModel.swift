//
//  InspectionViewModel.swift
//  tendableTest
//
//  Created by Kiran Babu Davis on 06/06/2023.
//

import Foundation

class InspectionViewModel: ObservableObject {
    @Published var surveyQuestions: [SurveyQuestion] = []
    @Published var selectedAnswerIds: [Int?] = []
    @Published var currentQuestionIndex = 0

    init() {
        loadSurveyQuestionsFromJSON()
        loadSelectedAnswerIds()
    }

    func loadSurveyQuestionsFromJSON() {
        guard let path = Bundle.main.path(forResource: "questions", ofType: "json") else {
            return
        }
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let inspectionData = try decoder.decode(InspectionData.self, from: jsonData)
            surveyQuestions = inspectionData.questions
        } catch {
            print("Error reading or decoding JSON: \(error)")
        }
    }

    func loadSelectedAnswerIds() {
        if let savedSelectedAnswerIds = UserDefaults.standard.array(forKey: "SelectedAnswerIds") as? [Int] {
            selectedAnswerIds = savedSelectedAnswerIds.map { $0 == 0 ? nil : $0 }
        } else {
            selectedAnswerIds = Array(repeating: nil, count: surveyQuestions.count)
        }
    }

    func isSelected(_ answerChoice: AnswerChoice) -> Bool {
        guard let selectedAnswer = selectedAnswer() else {
            return false
        }
        return selectedAnswer.id == answerChoice.id
    }

    func selectAnswer(_ answerChoice: AnswerChoice) {
        selectedAnswerIds[currentQuestionIndex] = answerChoice.id
        saveSelectedAnswerIds()
    }

    func selectedAnswer() -> AnswerChoice? {
        guard currentQuestionIndex >= 0 && currentQuestionIndex < surveyQuestions.count else {
            return nil
        }

        guard let selectedAnswerId = selectedAnswerIds[currentQuestionIndex] else {
            return nil
        }

        return surveyQuestions[currentQuestionIndex].answerChoices.first { $0.id == selectedAnswerId }
    }

    func goToNextQuestion() {
        if currentQuestionIndex < surveyQuestions.count - 1 {
            currentQuestionIndex += 1
        }
    }

    func getCurrentQuestion() -> SurveyQuestion? {
        guard currentQuestionIndex >= 0 && currentQuestionIndex < surveyQuestions.count else {
            return nil
        }
        return surveyQuestions[currentQuestionIndex]
    }

    func goToPreviousQuestion() {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
        }
    }

    var isFirstQuestion: Bool {
        return currentQuestionIndex == 0
    }

    func isLastQuestion() -> Bool {
        return currentQuestionIndex == surveyQuestions.count - 1
    }

    func saveSelectedAnswerIds() {
        let nonOptionalSelectedAnswerIds = selectedAnswerIds.map { $0 ?? 0 }
        UserDefaults.standard.set(nonOptionalSelectedAnswerIds, forKey: "SelectedAnswerIds")
    }
}
