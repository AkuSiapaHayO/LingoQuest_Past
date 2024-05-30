//
//  CrosswordView.swift
//  LingoQuest
//
//  Created by MacBook Pro on 24/05/24.
//
import SwiftUI

struct CrosswordView: View {
    @StateObject private var viewModel: CrosswordViewModel

    init(levelNumber: Int) {
        _viewModel = StateObject(wrappedValue: CrosswordViewModel(levelNumber: levelNumber))
    }

    var body: some View {
        VStack {
            List(viewModel.questions) { question in
                Text("\(question.direction) \(question.question)")
            }
            VStack(spacing: 0) {
                ForEach(viewModel.crosswordGrid.indices, id: \.self) { rowIndex in
                    HStack(spacing: 0) {
                        ForEach(viewModel.crosswordGrid[rowIndex].indices, id: \.self) { colIndex in
                            CellView(cell: viewModel.crosswordGrid[rowIndex][colIndex],
                                     isSelected: viewModel.selectedCell?.id == viewModel.crosswordGrid[rowIndex][colIndex].id,
                                     onTap: {
                                        viewModel.selectedCell = viewModel.crosswordGrid[rowIndex][colIndex]
                                     }, onCommit: {
                                        viewModel.checkForWin()
                                     })
                        }
                    }
                }
            }
            .padding()
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text("Congratulations!"), message: Text("You completed the crossword for level \(viewModel.currentLevel)!"), dismissButton: .default(Text("OK")))
            }
        }
    }
}
