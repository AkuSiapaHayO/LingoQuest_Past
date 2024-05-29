//
//  BlankSpaceViewModel.swift
//  LingoQuest
//
//  Created by MacBook Pro on 29/05/24.
//

import Foundation

class BlankSpaceViewModel: ObservableObject {
    @Published var currentLevel: Int
    @Published var currentQuestion: BlankSpaceModel?
    @Published var selectedWords: [String] = []

    private var questions: [BlankSpaceModel] = []

    init(level: Int) {
        self.currentLevel = level
        loadQuestions()
        loadCurrentQuestion()
    }

    func loadQuestions() {
        if let url = Bundle.main.url(forResource: "Questions", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let decodedQuestions = try? JSONDecoder().decode([BlankSpaceModel].self, from: data) {
            questions = decodedQuestions
        }
    }

    func loadCurrentQuestion() {
        currentQuestion = questions.first { $0.id == currentLevel }
    }

    func checkAnswer() -> Bool {
        guard let question = currentQuestion else { return false }
        return Set(selectedWords) == Set(question.correctWords)
    }

    func toggleSelection(of word: String) {
        if selectedWords.contains(word) {
            selectedWords.removeAll { $0 == word }
        } else {
            selectedWords.append(word)
        }
    }

    func completeLevel() {
        // Unlock the next level
        if let nextLevel = currentLevel < 15 ? currentLevel + 1 : nil {
            // Logic to unlock next level in LevelViewModel
            LevelViewModel().unlockNextLevel(currentLevel: currentLevel)
        }
    }
}

