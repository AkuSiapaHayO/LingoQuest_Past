//
//  CrosswordViewModel.swift
//  LingoQuest
//
//  Created by MacBook Pro on 30/05/24.
//

import SwiftUI
import Combine

class CrosswordViewModel: ObservableObject {
    @Published var crosswordGrid: [[CrosswordCell]] = []
    @Published var selectedCell: CrosswordCell?
    @Published var showingAlert: Bool = false
    @Published var currentLevel: Int
    @Published var questions: [CrosswordQuestionModel] = []
    
    private var dataManager = CrosswordDataManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    init(levelNumber: Int) {
        self.currentLevel = levelNumber
        loadLevel(levelNumber: levelNumber)
    }

    func loadLevel(levelNumber: Int) {
        guard let level = dataManager.getLevel(levelNumber: levelNumber) else { return }
        createGrid(from: level)
        self.questions = level.questions
    }

    private func createGrid(from level: CrosswordLevelModel) {
        let maxRow = level.answers.max(by: { $0.row < $1.row })?.row ?? 0
        let maxCol = level.answers.max(by: { $0.col < $1.col })?.col ?? 0
        
        var grid: [[CrosswordCell]] = Array(repeating: Array(repeating: CrosswordCell(id: 0, isEditable: false), count: maxCol + 1), count: maxRow + 1)
        
        for answer in level.answers {
            grid[answer.row][answer.col] = CrosswordCell(id: answer.row * (maxCol + 1) + answer.col, letter: "", isEditable: true)
        }
        
        self.crosswordGrid = grid
    }

    func checkForWin() {
        guard let level = dataManager.getLevel(levelNumber: currentLevel) else { return }
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
}
