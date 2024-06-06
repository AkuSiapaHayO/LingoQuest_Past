//
//  LevelsView.swift
//  LingoQuest
//
//  Created by Clarissa A. Herawan on 30/05/24.
//

import SwiftUI

struct LevelsView: View {
    @StateObject var levelsViewModel = LevelViewModel()
    @State private var selectedLevel: Int? = nil
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        Group {
            if UIDevice.current.userInterfaceIdiom == .pad {
                NavigationSplitView {
                    levelsListView
                } detail: {
                    if let selectedLevel = selectedLevel {
                        SayTheWordView(viewModel: SayTheWordViewModel(level: selectedLevel, levelViewModel: levelsViewModel))
                            .onAppear {
                                levelsViewModel.loadLevels()
                            }
                    } else {
                        Text("Select a level")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                }
            } else {
                NavigationStack {
                    levelsListView
                        .navigationDestination(for: Int.self) { level in
                            SayTheWordView(viewModel: SayTheWordViewModel(level: level, levelViewModel: levelsViewModel))
                                .onAppear {
                                    levelsViewModel.loadLevels()
                                }
                        }
                }
            }
        }
        .onAppear {
            levelsViewModel.loadLevels()
            if UIDevice.current.userInterfaceIdiom == .pad {
                loadFirstLevel()
            }
        }
    }
    
    var levelsListView: some View {
        VStack {
            Text("Select Level")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Text("SayTheWord")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
                ForEach(1...15, id: \.self) { level in
                    NavigationLink(
                        destination: SayTheWordView(viewModel: SayTheWordViewModel(level: level, levelViewModel: levelsViewModel))
                            .onAppear {
                                levelsViewModel.loadLevels()
                            }
                    ) {
                        Text("\(level)")
                            .padding()
                            .frame(width: buttonSize(), height: buttonSize())
                            .background(levelsViewModel.isUnlocked(level: level) ? Color.orange : Color.gray)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .font(.system(size: fontSize(), weight: .bold))
                    }
                    .disabled(!levelsViewModel.isUnlocked(level: level))
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 20)
    }
    
    func buttonSize() -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 80
        } else {
            return 75
        }
    }
    
    func fontSize() -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 40
        } else {
            return 25
        }
    }

    func loadFirstLevel() {
        selectedLevel = 1
    }
}

#Preview {
    LevelsView()
}
