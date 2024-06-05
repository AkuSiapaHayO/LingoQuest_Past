//
//  CellView.swift
//  LingoQuest
//
//  Created by MacBook Pro on 30/05/24.
//
import SwiftUI

struct CellView: View {
    @ObservedObject var cell: CrosswordCell
    var isSelected: Bool
    var onTap: () -> Void
    var onCommit: () -> Void
    var showTopBorder: Bool
    var showLeadingBorder: Bool
    var showBottomBorder: Bool
    var showTrailingBorder: Bool

    @State private var isEditing = false
    @FocusState private var isFocused: Bool

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(self.isSelected ? Color.blue : (self.cell.isEditable ? Color.white : Color.clear))

                if self.cell.isEditable {
                    CustomTextField(text: self.$cell.letter, isEditing: self.$isEditing, onCommit: {
                        self.onCommit()
                    })
                    .multilineTextAlignment(.center)
                    .font(Font.system(size: 20))
                    .background(Color.white)
                    .focused($isFocused)
                    .onTapGesture {
                        self.isFocused = true
                        self.onTap()
                    }
                } else if !self.cell.letter.isEmpty {
                    Text(self.cell.letter)
                        .font(Font.system(size: 20))
                        .background(Color.clear)
                }

                if let label = self.cell.label {
                    Text(label)
                        .font(.caption)
                        .padding(2)
                        .background(Color.white)
                        .cornerRadius(2)
                        .offset(x: 2, y: 2)
                }

                if showTopBorder {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black)
                        .offset(y: -0.5)
                }
                if showLeadingBorder {
                    Rectangle()
                        .frame(width: 1)
                        .foregroundColor(.black)
                        .offset(x: -0.5)
                }
                if showBottomBorder {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black)
                        .offset(y: geometry.size.height - 0.5)
                }
                if showTrailingBorder {
                    Rectangle()
                        .frame(width: 1)
                        .foregroundColor(.black)
                        .offset(x: geometry.size.width - 0.5)
                }
            }
            .onTapGesture {
                self.isFocused = true
                self.onTap()
            }
        }
        .aspectRatio(1, contentMode: .fit) // Ensure cells have a square aspect ratio
        .frame(minWidth: 40, minHeight: 40) // Ensure cells have a minimum size for readability
    }
}
