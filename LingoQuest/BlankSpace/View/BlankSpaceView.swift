//
//  BlankSpaceUI.swift
//  LingoQuest
//
//  Created by MacBook Pro on 29/05/24.
//

import SwiftUI

struct BlankSpaceView: View {
    @ObservedObject var viewModel: BlankSpaceViewModel

    var body: some View {
        VStack {
            Text("Level \(viewModel.currentLevel)")
                .font(.largeTitle)
                .padding()

            if let question = viewModel.currentQuestion {
                Text(question.paragraph)
                    .padding()

                ForEach(question.choices, id: \.self) { word in
                    WordButton(word: word, isSelected: viewModel.selectedWords.contains(word)) {
                        viewModel.toggleSelection(of: word)
                    }
                }

                Button(action: {
                    if viewModel.checkAnswer() {
                        viewModel.completeLevel()
                        // Show level completed popup and unlock next level
                    } else {
                        // Show try again popup
                    }
                }) {
                    Text("Answer")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

struct WordButton: View {
    var word: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(word)
                .padding()
                .background(isSelected ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding(4)
    }
}



//#Preview {
//    BlankSpaceView(viewModel: <#T##BlankSpaceViewModel#>)
//}
