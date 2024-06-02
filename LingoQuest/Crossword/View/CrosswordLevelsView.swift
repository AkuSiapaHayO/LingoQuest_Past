//
//  CrosswordLevelsView.swift
//  LingoQuest
//
//  Created by MacBook Pro on 02/06/24.
//

import SwiftUI


struct CrosswordLevelsView: View {
    @StateObject var levelsViewModel = CrosswordLevelViewModel()
    
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
                        NavigationLink(destination: CrosswordView(levelNumber: level, levelsViewModel: levelsViewModel).onAppear {
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

struct LevelsView_Previews: PreviewProvider {
    static var previews: some View {
        CrosswordLevelsView()
    }
}
#Preview {
    CrosswordLevelsView(levelsViewModel: CrosswordLevelViewModel())
}
