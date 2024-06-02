import SwiftUI

@main
struct LingoQuest_MacApp: App {
    var body: some Scene {
        WindowGroup {
            LevelViewMac(viewModel: LevelViewModel())
        }
    }
}

