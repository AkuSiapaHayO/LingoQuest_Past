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
            ZStack {
                Rectangle()
                    .fill(self.isSelected ? Color.blue : Color.white)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .border(Color.black, width: 1)
                
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
                } else {
                    Text(self.cell.letter)
                        .font(Font.system(size: 20))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .background(Color.white)
                }
            }
            .onTapGesture {
                self.isFocused = true
                self.onTap()
            }
        }
    }
}
