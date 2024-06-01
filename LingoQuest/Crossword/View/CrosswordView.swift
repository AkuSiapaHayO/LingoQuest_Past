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
                VStack(alignment: .leading) {
                    Text(question.direction)
                        .font(.headline)
                    Text(question.question)
                        .font(.body)
                }
            }
            VStack(spacing: 0) {
                ForEach(viewModel.crosswordGrid.indices, id: \.self) { rowIndex in
                    HStack(spacing: 0) {
                        ForEach(viewModel.crosswordGrid[rowIndex].indices, id: \.self) { colIndex in
                            let cell = viewModel.crosswordGrid[rowIndex][colIndex]
                            CellView(
                                cell: cell,
                                isSelected: viewModel.selectedCell?.id == cell.id,
                                onTap: {
                                    viewModel.selectedCell = cell
                                },
                                onCommit: {
                                    viewModel.checkForWin()
                                },
                                showTopBorder: cell.isEditable || showBorder(row: rowIndex, col: colIndex, direction: .top),
                                showLeadingBorder: cell.isEditable || showBorder(row: rowIndex, col: colIndex, direction: .leading),
                                showBottomBorder: cell.isEditable || showBorder(row: rowIndex, col: colIndex, direction: .bottom),
                                showTrailingBorder: cell.isEditable || showBorder(row: rowIndex, col: colIndex, direction: .trailing)
                            )
                        }
                    }
                }
            }
            .padding()
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(
                    title: Text("Congratulations!"),
                    message: Text("You completed the crossword for level \(viewModel.currentLevel)!"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    private func showBorder(row: Int, col: Int, direction: Edge) -> Bool {
        switch direction {
        case .top:
            return row > 0 && viewModel.crosswordGrid[row - 1][col].isEditable
        case .leading:
            return col > 0 && viewModel.crosswordGrid[row][col - 1].isEditable
        case .bottom:
            return row < viewModel.crosswordGrid.count - 1 && viewModel.crosswordGrid[row + 1][col].isEditable
        case .trailing:
            return col < viewModel.crosswordGrid[row].count - 1 && viewModel.crosswordGrid[row][col + 1].isEditable
        }
    }
}

// Safe array subscript extension
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
