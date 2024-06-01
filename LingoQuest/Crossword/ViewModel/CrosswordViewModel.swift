//
//  CrosswordViewModel.swift
//  LingoQuest
//
//  Created by MacBook Pro on 30/05/24.
//
import SwiftUI

class CrosswordViewModel: ObservableObject {
    @Published var crosswordGrid: [[CrosswordCell]] = []
    @Published var selectedCell: CrosswordCell?
    @Published var showingAlert: Bool = false
    @Published var currentLevel: Int
    @Published var questions: [CrosswordQuestionModel] = []
    
    private var levels: [CrosswordLevelModel] = []
    
    init(levelNumber: Int) {
        self.currentLevel = levelNumber
        loadLevelData()
        loadLevel(levelNumber: levelNumber)
    }

    func loadLevel(levelNumber: Int) {
        guard let level = levels.first(where: { $0.levelNumber == levelNumber }) else { return }
        createGrid(from: level)
        self.questions = level.questions
    }
    
    private func loadLevelData() {
        guard let url = Bundle.main.url(forResource: "CrosswordLevels", withExtension: "json") else {
            print("Failed to locate CrosswordLevels.json file in bundle.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            self.levels = try decoder.decode([CrosswordLevelModel].self, from: data)
        } catch {
            print("Failed to load or parse JSON data: \(error)")
        }
    }

    private func createGrid(from level: CrosswordLevelModel) {
        let maxRow = level.answers.max(by: { $0.row < $1.row })?.row ?? 0
        let maxCol = level.answers.max(by: { $0.col < $1.col })?.col ?? 0
        
        var grid: [[CrosswordCell]] = Array(repeating: Array(repeating: CrosswordCell(id: 0, isEditable: false), count: maxCol + 1), count: maxRow + 1)
        
        for answer in level.answers {
            grid[answer.row][answer.col] = CrosswordCell(id: answer.id, letter: "", isEditable: true)
        }
        
        self.crosswordGrid = grid
    }

    func checkForWin() {
        guard let level = levels.first(where: { $0.levelNumber == currentLevel }) else { return }
        if allAnswersCorrect(level: level) {
            self.showingAlert = true
        }
    }

    private func allAnswersCorrect(level: CrosswordLevelModel) -> Bool {
        for answer in level.answers {
            if crosswordGrid[answer.row][answer.col].letter.uppercased() != answer.letter {
                return false
            }
        }
        return true
    }
    
    // Default initializer for previews
    init() {
        self.currentLevel = 1
        self.levels = [
            CrosswordLevelModel(
                levelNumber: 1,
                questions: [
                    CrosswordQuestionModel(id: 1, direction: "mendatar", question: "Bahasa Inggrisnya 'kucing'", answer: "CAT"),
                    CrosswordQuestionModel(id: 2, direction: "menurun", question: "Bahasa Inggrisnya 'mobil'", answer: "CAR")
                ],
                answers: [
                    CrosswordAnswerModel(id: 1, row: 0, col: 0, letter: "C"),
                    CrosswordAnswerModel(id: 2, row: 0, col: 1, letter: "A"),
                    CrosswordAnswerModel(id: 3, row: 0, col: 2, letter: "T"),
                    CrosswordAnswerModel(id: 4, row: 1, col: 0, letter: "A"),
                    CrosswordAnswerModel(id: 5, row: 2, col: 0, letter: "R")
                ]
            )
        ]
        loadLevel(levelNumber: 1)
    }
}
