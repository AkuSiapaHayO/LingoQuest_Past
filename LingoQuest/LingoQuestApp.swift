//
//  LingoQuestApp.swift
//  LingoQuest
//
//  Created by MacBook Pro on 24/05/24.
//

import SwiftUI
import Speech
import AVFoundation

@main
struct LingoQuestApp: App {
    
    init() {
            requestSpeechAuthorization()
        }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
    
    private func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            switch authStatus {
            case .authorized:
                print("Speech recognition authorized")
            case .denied:
                print("Speech recognition denied")
            case .restricted:
                print("Speech recognition restricted")
            case .notDetermined:
                print("Speech recognition not determined")
            @unknown default:
                fatalError("Unknown speech recognition authorization status")
            }
        }
        
        AVAudioApplication.requestRecordPermission { granted in
            if granted {
                print("Microphone access granted")
            } else {
                print("Microphone access denied")
            }
        }
    }
}
