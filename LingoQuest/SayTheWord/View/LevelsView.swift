//
//  LevelsView.swift
//  LingoQuest
//
//  Created by Clarissa A. Herawan on 30/05/24.
//

import SwiftUI

struct LevelsView: View {
    @StateObject var levelsViewModel = LevelViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(1...15, id: \.self) { level in
                        NavigationLink(destination: SayTheWordView(viewModel: SayTheWordViewModel(level: level, levelViewModel: levelsViewModel)).onAppear {
                            levelsViewModel.loadLevels()
                        }) {
                            Text("Level \(level)")
                                .padding()
                                .background(levelsViewModel.isUnlocked(level: level) ? Color.green : Color.gray)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        }
                        .disabled(!levelsViewModel.isUnlocked(level: level))
                    }
                }
                .padding()
            }
            .onAppear {
                levelsViewModel.loadLevels()
            }
            .navigationTitle("Select Level")
        }
    }
}

#Preview {
    LevelsView()
}
