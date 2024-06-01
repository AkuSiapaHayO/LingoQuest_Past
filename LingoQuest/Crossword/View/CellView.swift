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
    
    @State private var isEditing = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(self.isSelected ? Color.blue : (self.cell.isEditable ? Color.white : Color.clear))
                    .border(self.cell.isEditable ? Color.black : Color.clear, width: 1)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                if self.cell.isEditable {
                    CustomTextField(text: self.$cell.letter, isEditing: self.$isEditing, onCommit: {
                        self.onCommit()
                    })
                    .multilineTextAlignment(.center)
                    .font(Font.system(size: 20))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(Color.white)
                    .border(Color.black, width: 1)
                    .textFieldStyle(PlainTextFieldStyle())
                    .focused($isFocused)
                    .onTapGesture {
                        self.isFocused = true
                        self.onTap()
                    }
                } else if self.cell.letter.isEmpty == false {
                    Text(self.cell.letter)
                        .font(Font.system(size: 20))
                        .frame(width: geometry.size.width, height: geometry.size.height)
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
            }
            .onTapGesture {
                self.isFocused = true
                self.onTap()
            }
        }
        .frame(minWidth: 40, minHeight: 40) // Ensure cells have a minimum size for readability
    }
}
