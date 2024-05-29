//
//  LevelViewModel.swift
//  LingoQuest
//
//  Created by MacBook Pro on 29/05/24.
//

import Foundation

class LevelViewModel: ObservableObject {
    @Published var levels: [LevelModel]

    init() {
        levels = (1...15).map { LevelModel(id: $0, isUnlocked: $0 == 1) }
    }

    func unlockNextLevel(currentLevel: Int) {
        if currentLevel < levels.count {
            levels[currentLevel].isUnlocked = true
        }
    }
}
