import SwiftUI

class LevelViewModel: ObservableObject {
    @Published var levelsData: [LevelData] = []

    init() {
        loadLevels()
    }

    func isUnlocked(level: Int) -> Bool {
        guard let levelData = levelsData.first(where: { $0.id == level }) else { return false }
        return levelData.isUnlocked
    }

    func loadLevels() {
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

    func unlockNextLevel(after level: Int) {
        if let index = levelsData.firstIndex(where: { $0.id == level }) {
            if index + 1 < levelsData.count {
                levelsData[index + 1].isUnlocked = true
                saveLevels()
            }
        }
    }

    private func saveLevels() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(levelsData)
            if let url = getDocumentsDirectory()?.appendingPathComponent("levels.json") {
                try data.write(to: url)
            }
        } catch {
            print("Failed to save level data: \(error)")
        }
    }

    private func getDocumentsDirectory() -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first
    }
}
