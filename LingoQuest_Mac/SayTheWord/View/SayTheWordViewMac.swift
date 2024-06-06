//
//  SayTheWordViewMac.swift
//  LingoQuest_Mac
//
//  Created by Clarissa A. Herawan on 05/06/24.
//

import SwiftUI
import Speech

struct SayTheWordViewMac: View {
    @ObservedObject var viewModel: SayTheWordViewModelMac
    @State private var isRecording = false
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Level \(viewModel.currentLevel)")
                .font(.system(size: titleFontSize(), weight: .bold))
                .padding(.top, 20)
            
            Text("Say The Word")
                .font(.system(size: headingFontSize(), weight: .bold))
                .padding(.bottom, 20)
            
            Text("Word: \(viewModel.currentWord)")
                .font(.system(size: wordFontSize()))
                .padding(.top, 10)
            
            Spacer()
            
            Button(action: {
                if isRecording {
                    stopTranscription()
                } else {
                    startTranscription()
                }
            }) {
                Image(systemName: isRecording ? "mic.fill" : "mic.slash.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
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
            .buttonStyle(PlainButtonStyle())
            .padding()
            
            Spacer()
            
            Text(isRecording ? "Microphone is active" : "Microphone is inactive")
                .font(.system(size: subtitleFontSize()))
                .foregroundColor(isRecording ? .gray : .red)
                .animation(.easeInOut, value: isRecording)
                .padding()
            
            Text(viewModel.transcript)
                .font(.system(size: transcriptFontSize()))
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
    
    private func titleFontSize() -> CGFloat {
        return 60
    }
    
    private func headingFontSize() -> CGFloat {
        return 40
    }
    
    private func wordFontSize() -> CGFloat {
        return 36
    }
    
    private func subtitleFontSize() -> CGFloat {
        return 24
    }
    
    private func transcriptFontSize() -> CGFloat {
        return 28
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
    SayTheWordViewMac(viewModel: SayTheWordViewModelMac(level: 1, levelViewModel: LevelViewModel()))
}
