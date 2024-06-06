//
//  SayTheWordViewModel.swift
//  LingoQuest
//
//  Created by Clarissa A. Herawan on 30/05/24.
//

import SwiftUI
import AVFoundation
import Speech

class SayTheWordViewModel: ObservableObject {
    @Published var currentLevel: Int
    @Published var currentWord: String = ""
    @Published var audioLevel: CGFloat = 0.0
    @Published var transcript: String = ""
    
    private var words: [LevelData] = []
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private var audioRecorder: AVAudioRecorder?
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
        guard !audioEngine.isRunning else { return }
        startSpeechRecognition()
        startAudioLevelMonitoring()
    }
    
    func stopListening() {
        guard audioEngine.isRunning else { return }
        audioEngine.stop()
        recognitionRequest?.endAudio()
        stopAudioLevelMonitoring()
        recognitionTask?.cancel()
    }
    
    func resetTranscript() {
        transcript = ""
    }
    
    private func startSpeechRecognition() {
        guard let recognizer = speechRecognizer, recognizer.isAvailable else {
            print("Speech recognizer is not available")
            return
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let request = recognitionRequest else { return }
        
        let inputNode = audioEngine.inputNode
        request.shouldReportPartialResults = true
        
        recognitionTask = recognizer.recognitionTask(with: request) { result, error in
            if let result = result {
                self.transcript = result.bestTranscription.formattedString
                if self.transcript.lowercased().contains(self.currentWord.lowercased()) {
                    self.audioEngine.stop()
                    inputNode.removeTap(onBus: 0)
                    self.recognitionRequest = nil
                    self.recognitionTask = nil
                    self.completeLevel()
                }
            }
            
            if let error = error {
                print("Recognition error: \(error.localizedDescription)")
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("Audio engine couldn't start: \(error.localizedDescription)")
        }
    }
    
    private func startAudioLevelMonitoring() {
        let audioSession = AVAudioSession.sharedInstance()
        let url = URL(fileURLWithPath: "/dev/null")
        let settings: [String: Any] = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
        ]
        
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true)
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.record()
            
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                self.audioRecorder?.updateMeters()
                let averagePower = self.audioRecorder?.averagePower(forChannel: 0) ?? -160
                self.audioLevel = CGFloat((averagePower + 180) / 160) // Normalize to 0...1
                if self.audioRecorder?.isRecording == false {
                    timer.invalidate()
                }
            }
        } catch {
            print("Audio level monitoring setup failed: \(error.localizedDescription)")
        }
    }
    
    private func stopAudioLevelMonitoring() {
        audioRecorder?.stop()
        audioRecorder = nil
    }
}
