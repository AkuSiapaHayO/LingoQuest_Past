//
//  CrosswordLevelModel.swift
//  LingoQuest
//
//  Created by MacBook Pro on 30/05/24.
import SwiftUI
import Combine

class CrosswordLevelModel: ObservableObject, Identifiable {
    @Published var id: UUID = UUID()
    @Published var levelNumber: Int
    @Published var questions: [CrosswordQuestionModel] = []
    @Published var answers: [CrosswordAnswerModel] = []
    
    init(levelNumber: Int, questions: [CrosswordQuestionModel], answers: [CrosswordAnswerModel]) {
        self.levelNumber = levelNumber
        self.questions = questions
        self.answers = answers
    }
}
