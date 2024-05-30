//
//  CrosswordQuestionModel.swift
//  LingoQuest
//
//  Created by MacBook Pro on 30/05/24.
//
import SwiftUI
import Combine

class CrosswordQuestionModel: ObservableObject, Identifiable {
    @Published var id: UUID = UUID()
    @Published var direction: String
    @Published var question: String
    @Published var answer: String
    
    init(direction: String, question: String, answer: String) {
        self.direction = direction
        self.question = question
        self.answer = answer
    }
}
