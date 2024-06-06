//
//  LevelsViewMac.swift
//  LingoQuest_Mac
//
//  Created by Clarissa A. Herawan on 31/05/24.
//

import SwiftUI

struct LevelsViewMac: View {
    @StateObject var levelsViewModel = LevelViewModel()
    @State private var selectedLevel: Int? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Select a Level")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 60), count: 3), spacing: 30) {
                    ForEach(1...15, id: \.self) { level in
                        NavigationLink(destination: SayTheWordViewMac(viewModel: SayTheWordViewModelMac(level: level, levelViewModel: levelsViewModel))) {
                            Text("\(level)")
                                .padding()
                                .frame(width: 50, height: 50)
                                .background(levelsViewModel.isUnlocked(level: level) ? Color.orange : Color.gray)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .bold))
                        }
                        .disabled(!levelsViewModel.isUnlocked(level: level))
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 20)
            .onAppear {
                levelsViewModel.loadLevels()
            }
        }
    }
}

#Preview {
    LevelsViewMac()
}
