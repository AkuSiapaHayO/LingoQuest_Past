//
//  LevelView.swift
//  LingoQuest
//
//  Created by MacBook Pro on 29/05/24.
//

import SwiftUI

struct LevelView: View {
    @ObservedObject var viewModel = LevelViewModel()

    var body: some View {
        VStack {
            Text("Levels")
                .font(.largeTitle)
                .padding()

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                ForEach(viewModel.levels) { level in
                    LevelButton(level: level, action: {
                        if level.isUnlocked {
                            // Navigate to BlankSpaceView with the selected level
                        }
                    })
                }
            }
        }
    }
}

struct LevelButton: View {
    var level: LevelModel
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Level \(level.id)")
                .padding()
                .frame(width: 100, height: 100)
                .background(level.isUnlocked ? Color.green : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .disabled(!level.isUnlocked)
    }
}


#Preview {
    LevelView()
}
