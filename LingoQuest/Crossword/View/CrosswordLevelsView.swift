//
//  CrosswordLevelsView.swift
//  LingoQuest
//
//  Created by MacBook Pro on 30/05/24.
//
import SwiftUI

struct CrosswordLevelsView: View {
    @StateObject var viewModel = CrosswordLevelsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                VStack {
                    Text("Select Level")
                        .font(.title)
                        .padding(.top, 20)
                    
                    Text("Crossword")
                        .font(.largeTitle)
                        .bold()
                    Text("Puzzle")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 20)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
                        ForEach(1...15, id: \.self) { level in
                            NavigationLink(destination: CrosswordView(levelNumber: level, levelsViewModel: viewModel)) {
                                Text("\(level)")
                                    .font(.title)
                                    .frame(width: 80, height: 80)
                                    .background(viewModel.isUnlocked(level: level) ? Color(red: 7 / 255, green: 169 / 255, blue: 243 / 255) : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .disabled(!viewModel.isUnlocked(level: level))
                        }
                    }
                    .padding()
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 20)
            .onAppear {
                viewModel.loadLevels()
            }
            .onChange(of: viewModel.unlockedLevels) { _ in
                viewModel.loadLevels()
            }
        }
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        CrosswordLevelsView(viewModel: CrosswordLevelsViewModel())
    }
}
