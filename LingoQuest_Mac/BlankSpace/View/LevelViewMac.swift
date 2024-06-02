import SwiftUI

struct LevelViewMac: View {
    @ObservedObject var viewModel: LevelViewModel
    @State private var selectedLevel: Int? = nil

    var body: some View {
        ZStack {
            VStack {
                Text("Select Level")
                    .font(.title)
                    .padding(.top, 40)
                    .foregroundColor(.black)
                Text("Blank Space")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 20)
                    .padding(.top, 1)
                    .foregroundColor(.black)
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 5), spacing: 20) {
                        ForEach(1...15, id: \.self) { level in
                            Button(action: {
                                if viewModel.isUnlocked(level: level) {
                                    selectedLevel = level
                                }
                            }) {
                                Text("\(level)")
                                    .font(.title)
                                    .frame(width: 80, height: 80)
                                    .background(viewModel.isUnlocked(level: level) ? Color(red: 59 / 255, green: 166 / 255, blue: 102 / 255) : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .buttonStyle(ClearLevelButtonStyle())
                            .disabled(!viewModel.isUnlocked(level: level))
                        }
                    }
                    .padding()
                }
                .padding(.horizontal, 20)
            }

            if let level = selectedLevel {
                LevelDetailViewMac(level: level, viewModel: viewModel) {
                    selectedLevel = nil
                }
                .transition(.move(edge: .trailing))
                .zIndex(1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            viewModel.loadLevels()
        }
        .background(Color.white)
    }
}

struct ClearLevelButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color.clear)
            .cornerRadius(8)
    }
}

struct LevelViewMac_Previews: PreviewProvider {
    static var previews: some View {
        LevelViewMac(viewModel: LevelViewModel())
    }
}

