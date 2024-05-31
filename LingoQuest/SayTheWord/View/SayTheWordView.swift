//
//  SayTheWordView.swift
//  LingoQuest
//
//  Created by Clarissa A. Herawan on 30/05/24.
//

//
//  SayTheWordView.swift
//  LingoQuest
//
//  Created by Clarissa A. Herawan on 30/05/24.
//

import SwiftUI
import AVFoundation

struct SayTheWordView: View {
    @ObservedObject var viewModel: SayTheWordViewModel
    @State private var isRecording = false
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Level \(viewModel.currentLevel)")
                .font(.largeTitle)
                .padding()
            
            Text("Word: \(viewModel.currentWord)")
                .font(.title)
                .padding()
            
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 100, height: 100)
                
                Circle()
                    .fill(Color.blue.opacity(0.5))
                    .frame(width: 100 * viewModel.audioLevel, height: 100 * viewModel.audioLevel)
                    .animation(.easeInOut, value: viewModel.audioLevel)
                
                Button(action: {
                    if isRecording {
                        stopTranscription()
                    } else {
                        startTranscription()
                    }
                }) {
                    Image(systemName: isRecording ? "mic.fill" : "mic.slash.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                        .background(isRecording ? Color.blue : Color.red)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(isRecording ? Color.blue : Color.red, lineWidth: 4)
                                .scaleEffect(isRecording ? 1.2 : 1)
                                .opacity(isRecording ? 0.5 : 1)
                        )
                        .animation(.easeInOut(duration: 0.3), value: isRecording)
                }
                .padding()
            }
            
            Text(isRecording ? "Microphone is active" : "Microphone is inactive")
                .font(.headline)
                .foregroundColor(isRecording ? .gray : .red)
                .animation(.easeInOut, value: isRecording)
                .padding()
            
            Text(viewModel.transcript)
                .padding()
                .onChange(of: viewModel.transcript) { newTranscript in
                    if newTranscript.lowercased().contains(viewModel.currentWord.lowercased()) {
                        viewModel.completeLevel()
                        viewModel.resetTranscript()
                        stopTranscription()
                        showAlert = true
                    }
                }

            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Congratulations!"),
                message: Text("You have completed the level."),
                dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .onAppear {
            viewModel.loadLevel()
        }
    }
    
    private func startTranscription() {
        viewModel.resetTranscript()
        viewModel.startListening()
        isRecording = true
    }
    
    private func stopTranscription() {
        viewModel.stopListening()
        isRecording = false
    }
}

#Preview {
    SayTheWordView(viewModel: SayTheWordViewModel(level: 1, levelViewModel: LevelViewModel()))
}
