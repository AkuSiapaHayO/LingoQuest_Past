import SwiftUI

struct BlankSpaceView: View {
    @ObservedObject var viewModel: BlankSpaceViewModel
    @State private var selectedWords: [String] = []
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            VStack(spacing: 16) {
                Spacer()
                Text("Blank Space")
                    .font(.title)

                Text("Level \(viewModel.currentLevel)")
                    .font(.largeTitle)
                    .bold()

                ScrollView {
                    Text(viewModel.paragraph)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.title3)
                }
                .frame(maxHeight: 120) // Adjust this height as necessary
                .padding(.top, 48)

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
                                        .background(selectedWords.contains(word) ? Color(red: 59 / 255, green: 166 / 255, blue: 102 / 255) : Color.clear)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(selectedWords.contains(word) ? Color(red: 59 / 255, green: 166 / 255, blue: 102 / 255) : (colorScheme == .dark ? Color.white : Color.black), lineWidth: 2)
                                        )
                                        .foregroundColor(selectedWords.contains(word) ? Color.white : (colorScheme == .dark ? Color.white : Color.black))
                                        .cornerRadius(8)
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
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color(red: 59 / 255, green: 166 / 255, blue: 102 / 255))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 32)
                Spacer()
            }
            .onAppear {
                viewModel.loadLevel()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        let maxWidth: CGFloat = UIScreen.main.bounds.width - 80 // Adjust this value as necessary

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
        BlankSpaceView(viewModel: BlankSpaceViewModel(level: 8))
    }
}

