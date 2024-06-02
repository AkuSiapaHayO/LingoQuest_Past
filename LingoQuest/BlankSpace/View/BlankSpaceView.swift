import SwiftUI

struct BlankSpaceView: View {
    @ObservedObject var viewModel: BlankSpaceViewModel
    @State private var selectedWords: [String] = []
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Level \(viewModel.currentLevel)")
                .font(.largeTitle)
                .padding()

            ScrollView {
                Text(viewModel.paragraph)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxHeight: 200) // Adjust this height as necessary

            VStack {
                // Wrapping words manually into rows
                let rows = createRows(words: viewModel.choices)
                ForEach(rows, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { word in
                            Button(action: {
                                if selectedWords.contains(word) {
                                    selectedWords.removeAll { $0 == word }
                                } else {
                                    selectedWords.append(word)
                                }
                            }) {
                                Text(word)
                                    .padding()
                                    .background(selectedWords.contains(word) ? Color.blue : Color.gray)
                                    .cornerRadius(8)
                                    .foregroundColor(.white)
                                    .fixedSize(horizontal: true, vertical: false) // Prevent word wrapping
                            }
                        }
                    }
                }
            }
            .padding()

            Button(action: {
                if viewModel.checkAnswer(selectedWords: selectedWords) {
                    viewModel.completeLevel()
                } else {
                    selectedWords.removeAll()
                }
            }) {
                Text("Answer")
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .onAppear {
            viewModel.loadLevel()
        }
        .alert(isPresented: $viewModel.showCompletionPopup) {
            Alert(
                title: Text("Level Completed"),
                message: Text("You have completed the level."),
                dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }

    // Helper function to create rows of words
    func createRows(words: [String]) -> [[String]] {
        var rows: [[String]] = []
        var currentRow: [String] = []
        var currentWidth: CGFloat = 0
        let maxWidth: CGFloat = UIScreen.main.bounds.width - 40 // Adjust this value as necessary

        for word in words {
            let wordWidth = (word as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: 17)]).width + 30 // Adjust padding as necessary
            if currentWidth + wordWidth > maxWidth {
                rows.append(currentRow)
                currentRow = [word]
                currentWidth = wordWidth
            } else {
                currentRow.append(word)
                currentWidth += wordWidth
            }
        }

        if !currentRow.isEmpty {
            rows.append(currentRow)
        }

        return rows
    }
}

struct BlankSpaceView_Previews: PreviewProvider {
    static var previews: some View {
        BlankSpaceView(viewModel: BlankSpaceViewModel(level: 1))
    }
}

