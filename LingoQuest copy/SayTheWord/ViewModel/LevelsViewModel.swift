//
//  LevelsViewModel.swift
//  LingoQuest
//
//  Created by Clarissa A. Herawan on 30/05/24.
//

import SwiftUI

class LevelViewModel: ObservableObject {
    @Published var levelsData: [LevelData] = []
    @Published var unlockedLevels: [Int] = UserDefaults.standard.array(forKey: "unlockedLevels") as? [Int] ?? [1]

    init() {
        loadLevels()
    }

    func isUnlocked(level: Int) -> Bool {
        return unlockedLevels.contains(level)
    }

    func loadLevels() {
        if let url = Bundle.main.url(forResource: "words", withExtension: "json") {
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
        if !unlockedLevels.contains(level + 1) && level + 1 <= levelsData.count {
            unlockedLevels.append(level + 1)
            UserDefaults.standard.set(unlockedLevels, forKey: "unlockedLevels")
        }
    }
}
