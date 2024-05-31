import SwiftUI

class BlankSpaceViewModel: ObservableObject {
    @Published var currentLevel: Int
    @Published var paragraph: String = ""
    @Published var choices: [String] = []
    @Published var showCompletionPopup: Bool = false

    private var correctAnswers: [String] = []
    private var levelsData: [LevelData] = []

    init(level: Int) {
        self.currentLevel = level
        loadLevelData()
        loadLevel()
    }

    func loadLevel() {
        guard let levelData = levelsData.first(where: { $0.id == currentLevel }) else { return }
        paragraph = levelData.paragraph
        choices = levelData.choices.shuffled()
        correctAnswers = levelData.correctAnswer
    }

    func checkAnswer(selectedWords: [String]) -> Bool {
        return selectedWords.sorted() == correctAnswers.sorted()
    }

    func completeLevel() {
        showCompletionPopup = true
        unlockNextLevel()
    }

    private func loadLevelData() {
        if let url = Bundle.main.url(forResource: "levels", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                levelsData = try decoder.decode([LevelData].self, from: data)
            } catch {
                print("Failed to load level data: \(error)")
            }
        }
    }

    private func unlockNextLevel() {
        let nextLevel = currentLevel + 1
        UserDefaults.standard.set(true, forKey: "level_\(nextLevel)_unlocked")
    }
}

