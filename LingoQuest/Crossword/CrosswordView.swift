//
//  CrosswordView.swift
//  LingoQuest
//
//  Created by MacBook Pro on 24/05/24.
//

import SwiftUI

class CrosswordViewModel: ObservableObject {
    @Published var crosswordGrid: [[CrosswordCell]]
    @Published var selectedCell: CrosswordCell?
    @Published var showingAlert: Bool = false

    init() {
        self.crosswordGrid = [
            [CrosswordCell(id: 0, isEditable: true), CrosswordCell(id: 1, isEditable: true), CrosswordCell(id: 2, isEditable: true)],
            [CrosswordCell(id: 3, isEditable: true), CrosswordCell(id: 4, isEditable: false), CrosswordCell(id: 5, isEditable: false)],
            [CrosswordCell(id: 6, isEditable: true), CrosswordCell(id: 7, isEditable: false), CrosswordCell(id: 8, isEditable: false)]
        ]
    }

    func checkForWin() {
        let correctAnswers = [
            ["C", "A", "T"],
            ["A", "", ""],
            ["R", "", ""]
        ]
        
        for rowIndex in crosswordGrid.indices {
            for colIndex in crosswordGrid[rowIndex].indices {
                if crosswordGrid[rowIndex][colIndex].isEditable {
                    if crosswordGrid[rowIndex][colIndex].letter.uppercased() != correctAnswers[rowIndex][colIndex] {
                        return
                    }
                }
            }
        }
        
        // If all filled letters are correct, show alert
        self.showingAlert = true
    }
}

struct CrosswordView: View {
    @StateObject private var viewModel = CrosswordViewModel()

    var body: some View {
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
            Alert(title: Text("Congratulations!"), message: Text("You completed the crossword!"), dismissButton: .default(Text("OK")))
        }
    }
}

