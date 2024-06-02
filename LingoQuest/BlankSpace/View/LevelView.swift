import SwiftUI

struct LevelView: View {
    @ObservedObject var viewModel: LevelViewModel

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                VStack {
                    Text("Select Level")
                        .font(.title)
                        .padding(.top, 20)
                    
                    Text("Blank Space")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 20)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
                        ForEach(1...15, id: \.self) { level in
                            NavigationLink(destination: BlankSpaceView(viewModel: BlankSpaceViewModel(level: level))) {
                                Text("\(level)")
                                    .font(.title)
                                    .frame(width: 80, height: 80)
                                    .background(viewModel.isUnlocked(level: level) ? Color(red: 59 / 255, green: 166 / 255, blue: 102 / 255) : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .disabled(!viewModel.isUnlocked(level: level))
                        }
                    }
                    .padding()
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 20)
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

