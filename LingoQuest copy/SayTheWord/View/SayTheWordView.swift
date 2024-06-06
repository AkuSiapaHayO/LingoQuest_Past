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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        GeometryReader { geometry in
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
                
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: circleSize(geometry: geometry), height: circleSize(geometry: geometry))
                    
                    Circle()
                        .fill(Color.blue.opacity(0.5))
                        .frame(width: circleSize(geometry: geometry) * viewModel.audioLevel, height: circleSize(geometry: geometry) * viewModel.audioLevel)
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
                            .frame(width: micButtonSize(geometry: geometry), height: micButtonSize(geometry: geometry))
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
    }
    
    private func circleSize(geometry: GeometryProxy) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return min(geometry.size.width, geometry.size.height) / 3
        } else {
            return 160
        }
    }
    
    private func micButtonSize(geometry: GeometryProxy) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return min(geometry.size.width, geometry.size.height) / 6
        } else {
            return 100
        }
    }
    
    private func titleFontSize() -> CGFloat {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 60
            } else {
                return 30
            }
        }
        
        private func headingFontSize() -> CGFloat {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 40
            } else {
                return 20
            }
        }
        
        private func wordFontSize() -> CGFloat {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 36
            } else {
                return 18
            }
        }
        
        private func subtitleFontSize() -> CGFloat {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 36
            } else {
                return 12
            }
        }
        
        private func transcriptFontSize() -> CGFloat {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 36
            } else {
                return 14
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
