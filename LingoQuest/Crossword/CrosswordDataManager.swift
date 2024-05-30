//
//  CrosswordDataManager.swift
//  LingoQuest
//
//  Created by MacBook Pro on 30/05/24.
//
import Combine

class CrosswordDataManager: ObservableObject {
    static let shared = CrosswordDataManager()
    @Published var levels: [CrosswordLevelModel] = []

    private init() {
        loadSampleData()
    }

    func loadSampleData() {
        // Level 1
        var levelQuestions = [
            CrosswordQuestionModel(direction: "mendatar", question: "Bahasa Inggrisnya 'kucing'", answer: "CAT"),
            CrosswordQuestionModel(direction: "menurun", question: "Bahasa Inggrisnya 'mobil'", answer: "CAR")
        ]
        
        var levelAnswers = [
            CrosswordAnswerModel(row: 0, col: 0, letter: "C"),
            CrosswordAnswerModel(row: 0, col: 1, letter: "A"),
            CrosswordAnswerModel(row: 0, col: 2, letter: "T"),
            CrosswordAnswerModel(row: 1, col: 0, letter: "A"),
            CrosswordAnswerModel(row: 2, col: 0, letter: "R")
        ]
        
        var level = CrosswordLevelModel(levelNumber: 1, questions: levelQuestions, answers: levelAnswers)
        self.levels.append(level)
        
        // Level 2
        levelQuestions = [
            CrosswordQuestionModel(direction: "mendatar", question: "Bahasa Inggrisnya 'ikan'", answer: "FISH"),
            CrosswordQuestionModel(direction: "menurun", question: "Bahasa Inggrisnya 'kapal'", answer: "SHIP")
        ]
        
        levelAnswers = [
            CrosswordAnswerModel(row: 0, col: 0, letter: "F"),
            CrosswordAnswerModel(row: 0, col: 1, letter: "I"),
            CrosswordAnswerModel(row: 0, col: 2, letter: "S"),
            CrosswordAnswerModel(row: 0, col: 3, letter: "H"),
            CrosswordAnswerModel(row: 1, col: 2, letter: "H"),
            CrosswordAnswerModel(row: 2, col: 2, letter: "I"),
            CrosswordAnswerModel(row: 3, col: 2, letter: "P")
        ]
        
        level = CrosswordLevelModel(levelNumber: 2, questions: levelQuestions, answers: levelAnswers)
        self.levels.append(level)
        
        // Level 3
        levelQuestions = [
            CrosswordQuestionModel(direction: "mendatar", question: "Bahasa Inggrisnya 'raja'", answer: "KING"),
            CrosswordQuestionModel(direction: "menurun", question: "Bahasa Inggrisnya 'besar'", answer: "BIG"),
            CrosswordQuestionModel(direction: "menurun", question: "Bahasa Inggrisnya 'permainan'", answer: "GAME")
        ]
        
        levelAnswers = [
            CrosswordAnswerModel(row: 1, col: 0, letter: "K"),
            CrosswordAnswerModel(row: 1, col: 1, letter: "I"),
            CrosswordAnswerModel(row: 1, col: 2, letter: "N"),
            CrosswordAnswerModel(row: 1, col: 3, letter: "G"),
            CrosswordAnswerModel(row: 0, col: 1, letter: "B"),
            CrosswordAnswerModel(row: 2, col: 1, letter: "G"),
            CrosswordAnswerModel(row: 2, col: 3, letter: "A"),
            CrosswordAnswerModel(row: 3, col: 3, letter: "M"),
            CrosswordAnswerModel(row: 4, col: 3, letter: "E"),
        ]
        
        level = CrosswordLevelModel(levelNumber: 3, questions: levelQuestions, answers: levelAnswers)
        self.levels.append(level)
    }
    
    func getLevel(levelNumber: Int) -> CrosswordLevelModel? {
        return levels.first { $0.levelNumber == levelNumber }
    }
}
