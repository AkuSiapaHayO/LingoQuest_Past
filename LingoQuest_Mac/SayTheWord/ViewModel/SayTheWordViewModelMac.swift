//
//  SayTheWordViewModelMac.swift
//  LingoQuest_Mac
//
//  Created by Clarissa A. Herawan on 05/06/24.
//

import SwiftUI
import Speech
import AVFoundation

class SayTheWordViewModelMac: ObservableObject {
    @Published var currentLevel: Int
    @Published var currentWord: String = ""
    @Published var transcript: String = ""
    
    private var words: [LevelData] = []
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private var levelViewModel: LevelViewModel

    init(level: Int, levelViewModel: LevelViewModel) {
        self.currentLevel = level
        self.levelViewModel = levelViewModel
        loadWordsData()
        loadLevel()
    }
    
    func loadWordsData() {
        if let url = Bundle.main.url(forResource: "words", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                words = try decoder.decode([LevelData].self, from: data)
            } catch {
                print("Failed to load words data: \(error)")
            }
        }
    }
    
    func loadLevel() {
        guard let wordData = words.first(where: { $0.id == currentLevel }) else { return }
        currentWord = wordData.correctAnswer
    }
    
    func completeLevel() {
        levelViewModel.unlockNextLevel(after: currentLevel)
    }
    
    func startListening() {
        guard let recognizer = speechRecognizer, recognizer.isAvailable else {
            print("Speech recognizer is not available")
            return
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let request = recognitionRequest else { return }
        
        request.shouldReportPartialResults = true
        
        recognitionTask = recognizer.recognitionTask(with: request) { result, error in
            if let result = result {
                self.transcript = result.bestTranscription.formattedString
                print("Transcription: \(self.transcript)") // Debugging log
                if self.transcript.lowercased().contains(self.currentWord.lowercased()) {
                    self.completeLevel()
                    self.resetTranscript()
                    self.stopListening()
                }
            }
            
            if let error = error {
                print("Recognition error: \(error.localizedDescription)")
                self.stopListening()
            }
        }
        
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.removeTap(onBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            request.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
            print("Audio engine started successfully")
        } catch {
            print("Audio engine couldn't start: \(error.localizedDescription)")
        }
    }
    
    func stopListening() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        recognitionRequest = nil
        recognitionTask = nil
    }
    
    func resetTranscript() {
        transcript = ""
    }
}
