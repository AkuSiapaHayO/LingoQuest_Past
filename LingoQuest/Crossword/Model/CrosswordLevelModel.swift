//
//  CrosswordLevelModel.swift
//  LingoQuest
//
//  Created by MacBook Pro on 30/05/24.
import Foundation

struct CrosswordLevelModel: Codable {
    let levelNumber: Int
    let questions: [CrosswordQuestionModel]
    let answers: [CrosswordAnswerModel]
}
