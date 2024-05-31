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

            Text(viewModel.paragraph)
                .padding()

            VStack {
                ForEach(viewModel.choices, id: \.self) { word in
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
}

struct BlankSpaceView_Previews: PreviewProvider {
    static var previews: some View {
        BlankSpaceView(viewModel: BlankSpaceViewModel(level: 1))
    }
}

