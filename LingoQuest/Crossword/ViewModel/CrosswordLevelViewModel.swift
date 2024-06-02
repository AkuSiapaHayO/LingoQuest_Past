//
//  CrosswordLevelViewModel.swift
//  LingoQuest
//
//  Created by MacBook Pro on 02/06/24.
//

import SwiftUI

class CrosswordLevelViewModel: ObservableObject {
    @Published var levels: [CrosswordLevelModel] = []
    @Published var unlockedLevels: [Int] = UserDefaults.standard.array(forKey: "unlockedLevels") as? [Int] ?? [1]

    init() {
        loadLevels()
    }

    func isUnlocked(level: Int) -> Bool {
        return unlockedLevels.contains(level)
    }

    func loadLevels() {
        if let url = Bundle.main.url(forResource: "CrosswordLevels", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                self.levels = try decoder.decode([CrosswordLevelModel].self, from: data)
            } catch {
                print("Failed to load level data: \(error)")
            }
        }
    }

    func unlockNextLevel(after level: Int) {
        if !unlockedLevels.contains(level + 1) && level + 1 <= levels.count {
            unlockedLevels.append(level + 1)
            UserDefaults.standard.set(unlockedLevels, forKey: "unlockedLevels")
        }
    }
}
