import Foundation

struct LevelData: Codable {
    let id: Int
    let paragraph: String
    let correctAnswer: [String]
    let choices: [String]
    var isUnlocked: Bool
}
