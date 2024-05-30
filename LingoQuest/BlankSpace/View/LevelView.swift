import SwiftUI

struct LevelView: View {
    @ObservedObject var viewModel: LevelViewModel

    var body: some View {
        NavigationView {
            VStack {
                ForEach(0..<3) { row in
                    HStack {
                        ForEach(0..<5) { column in
                            let level = row * 5 + column + 1
                            NavigationLink(destination: BlankSpaceView(viewModel: BlankSpaceViewModel(level: level))) {
                                Text("\(level)")
                                    .frame(width: 60, height: 60)
                                    .background(viewModel.isUnlocked(level: level) ? Color.blue : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .disabled(!viewModel.isUnlocked(level: level))
                        }
                    }
                }
            }
            .padding()
            .onAppear {
                viewModel.loadLevels()
            }
        }
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView(viewModel: LevelViewModel())
    }
}
