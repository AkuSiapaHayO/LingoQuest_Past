//
//  CrosswordLevelsViewModel.swift
//  LingoQuest
//
//  Created by MacBook Pro on 30/05/24.
//

import SwiftUI

class CrosswordLevelsViewModel: ObservableObject {
    @Published var levelsData: [CrosswordLevelModel] = []
    @Published var unlockedLevels: [Int] = []

    init() {
        loadLevels()
        loadUnlockedLevels()
    }

    func isUnlocked(level: Int) -> Bool {
        if level == 1 {
            return true
        }
        return unlockedLevels.contains(level)
    }

    func loadLevels() {
        if let url = Bundle.main.url(forResource: "CrosswordLevels", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                levelsData = try decoder.decode([CrosswordLevelModel].self, from: data)
            } catch {
                print("Failed to load level data: \(error)")
            }
        }
    }

    func loadUnlockedLevels() {
        for level in 2...15 {
            if UserDefaults.standard.bool(forKey: "level_\(level)_unlocked") {
                unlockedLevels.append(level)
            }
        }
    }

    func unlockNextLevel(after level: Int) {
        let nextLevel = level + 1
        UserDefaults.standard.set(true, forKey: "level_\(nextLevel)_unlocked")
        unlockedLevels.append(nextLevel)
    }
}
