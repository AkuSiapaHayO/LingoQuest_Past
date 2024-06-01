//
//  CrosswordQuestionModel.swift
//  LingoQuest
//
//  Created by MacBook Pro on 30/05/24.
//
import Foundation

struct CrosswordQuestionModel: Codable, Identifiable {
    let id: Int
    let direction: String
    let question: String
    let answer: String
}
