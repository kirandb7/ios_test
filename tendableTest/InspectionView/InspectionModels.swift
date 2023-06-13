//
//  InspectionModels.swift
//  tendableTest
//
//  Created by Kiran Babu Davis on 06/06/2023.
//

import Foundation


struct InspectionType: Identifiable, Codable {
    let id: UUID
    let name: String
    var questions: [Question]
}

struct Question: Identifiable, Codable {
    let id: UUID
    var questionText: String
    var answerChoices: [AnswerChoice]
}

struct Inspection: Identifiable, Codable {
    let id: UUID
    var inspectionType: InspectionType
    var answers: [Answer]
}

struct Answer: Identifiable, Codable {
    let id: UUID
    var question: Question
    var selectedAnswer: AnswerChoice
}

struct InspectionData: Codable {
    let questions: [SurveyQuestion]
}

struct SurveyQuestion: Codable, Identifiable {
    let id: Int
    let name: String
    let answerChoices: [AnswerChoice]
    let selectedAnswerChoiceId: Int?
}

struct AnswerChoice: Codable, Identifiable {
    let id: Int
    let name: String
    let score: Double
}
