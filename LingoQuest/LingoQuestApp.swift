import SwiftUI

@main
struct LingoQuestApp: App {
    var body: some Scene {
        WindowGroup {
            LevelView(viewModel: LevelViewModel())
        }
    }
}

