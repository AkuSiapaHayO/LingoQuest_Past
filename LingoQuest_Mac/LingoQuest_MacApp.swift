//
//  LingoQuest_MacApp.swift
//  LingoQuest_Mac
//
//  Created by MacBook Pro on 24/05/24.
//

import SwiftUI
import Speech

@main
struct LingoQuest_MacApp: App {
    @StateObject private var levelsViewModel = LevelViewModel()
    @State private var speechAuthorized = false

    var body: some Scene {
        WindowGroup {
            if speechAuthorized {
                LevelsViewMac()
                    .environmentObject(levelsViewModel)
            } else {
                Text("Requesting permissions...")
                    .onAppear {
                        requestPermissions()
                    }
            }
        }
    }

    private func requestPermissions() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized:
                    self.speechAuthorized = true
                case .denied, .restricted, .notDetermined:
                    self.speechAuthorized = false
                @unknown default:
                    self.speechAuthorized = false
                }
            }
        }
    }
}
