//
//  CrosswordView.swift
//  LingoQuest
//
//  Created by MacBook Pro on 24/05/24.
//

import SwiftUI

struct CrosswordCell: Identifiable {
    let id: Int
    var letter: String = ""
    var isEditable: Bool
}

struct CrosswordView: View {
    @State private var crosswordGrid: [[CrosswordCell]] = [
        [CrosswordCell(id: 0, letter: "", isEditable: true), CrosswordCell(id: 1, letter: "", isEditable: true), CrosswordCell(id: 2, letter: "", isEditable: true)],
        [CrosswordCell(id: 3, letter: "", isEditable: true), CrosswordCell(id: 4, letter: "", isEditable: false), CrosswordCell(id: 5, letter: "", isEditable: false)],
        [CrosswordCell(id: 6, letter: "", isEditable: true), CrosswordCell(id: 7, letter: "", isEditable: false), CrosswordCell(id: 8, letter: "", isEditable: false)]
    ]
    
    @State private var selectedCell: CrosswordCell? = nil
    @State private var showingAlert = false
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(crosswordGrid.indices, id: \.self) { rowIndex in
                HStack(spacing: 0) {
                    ForEach(self.crosswordGrid[rowIndex].indices, id: \.self) { colIndex in
                        CellView(cell: self.$crosswordGrid[rowIndex][colIndex],
                                 isSelected: self.selectedCell?.id == self.crosswordGrid[rowIndex][colIndex].id,
                                 onTap: {
                                    self.selectedCell = self.crosswordGrid[rowIndex][colIndex]
                                 }, onCommit: checkForWin)
                    }
                }
            }
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Congratulations!"), message: Text("You completed the crossword!"), dismissButton: .default(Text("OK")))
        }
    }
    
    private func checkForWin() {
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

struct CellView: View {
    @Binding var cell: CrosswordCell
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

struct CustomTextField: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextField

        init(parent: CustomTextField) {
            self.parent = parent
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            self.parent.isEditing = false
            self.parent.onCommit()
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            self.parent.isEditing = true
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            if let text = textField.text {
                // Limit the text to a single character
                if text.count > 1 {
                    textField.text = String(text.prefix(1))
                }
                self.parent.text = textField.text ?? ""
            }
        }
    }

    @Binding var text: String
    @Binding var isEditing: Bool
    var onCommit: () -> Void

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.addTarget(context.coordinator, action: #selector(context.coordinator.textFieldDidChange(_:)), for: .editingChanged)
        textField.returnKeyType = .done
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 20)
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        if isEditing {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}

struct CrosswordPreView: View {
    var body: some View {
        CrosswordView()
    }
}

#Preview {
    CrosswordPreView()
}
