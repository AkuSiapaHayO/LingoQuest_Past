//
//  CustomTextField.swift
//  LingoQuest
//
//  Created by MacBook Pro on 30/05/24.
//
import SwiftUI

struct CustomTextField: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextField

        init(parent: CustomTextField) {
            self.parent = parent
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            self.parent.isEditing = false
            self.parent.onCommit()
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            self.parent.isEditing = true
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            if let text = textField.text {
                // Limit the text to a single character
                if text.count > 1 {
                    textField.text = String(text.prefix(1))
                }
                self.parent.text = textField.text ?? ""
            }
        }
    }

    @Binding var text: String
    @Binding var isEditing: Bool
    var onCommit: () -> Void

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.addTarget(context.coordinator, action: #selector(context.coordinator.textFieldDidChange(_:)), for: .editingChanged)
        textField.returnKeyType = .done
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 20)
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        if isEditing {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}
