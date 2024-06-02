import SwiftUI

struct LevelDetailViewMac: View {
    var level: Int
    @ObservedObject var viewModel: LevelViewModel
    var onBack: () -> Void

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    onBack()
                }) {
                    Image(systemName: "arrow.backward")
                        .font(.title)
                        .padding()
                        .foregroundColor(.black)
                        .buttonStyle(ClearButtonStyle())
                }
                Spacer()
            }
            .background(Color(.white))
            .padding(.top, 20)

            BlankSpaceViewMac(viewModel: BlankSpaceViewModel(level: level))
        }
        .background(Color.white.opacity(1)) // Make background opaque
        .edgesIgnoringSafeArea(.all)
    }
}

struct ClearLevelDetailButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color.clear)
            .cornerRadius(8)
            .shadow(radius: 0) // Remove shadow
    }
}


struct LevelDetailViewMac_Previews: PreviewProvider {
    static var previews: some View {
        LevelDetailViewMac(level: 1, viewModel: LevelViewModel()) {}
    }
}

