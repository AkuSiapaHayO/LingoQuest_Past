import SwiftUI
import AVFoundation

class BlankSpaceViewModel: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    @Published var currentLevel: Int
    @Published var paragraph: String = ""
    @Published var choices: [String] = []
    @Published var showCompletionPopup: Bool = false

    private var correctAnswers: [String] = []
    private var levelsData: [LevelData] = []
    private var synthesizer = AVSpeechSynthesizer()
    private var speechCompletion: (() -> Void)?

    init(level: Int) {
        self.currentLevel = level
        super.init()
        loadLevelData()
        loadLevel()
        synthesizer.delegate = self
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
        let filledParagraph = getFilledParagraph()
        speak(text: filledParagraph) { [weak self] in
            self?.showCompletionPopup = true
            self?.unlockNextLevel()
        }
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

    private func getFilledParagraph() -> String {
        var filledParagraph = paragraph
        var index = filledParagraph.startIndex

        for answer in correctAnswers {
            if let range = filledParagraph.range(of: "____") {
                filledParagraph.replaceSubrange(range, with: answer)
                index = range.upperBound
            }
        }

        return filledParagraph
    }

    private func speak(text: String, completion: @escaping () -> Void) {
        self.speechCompletion = completion
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        speechCompletion?()
    }
}

