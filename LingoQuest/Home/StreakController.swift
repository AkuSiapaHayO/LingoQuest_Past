//
//  StreakController.swift
//  LingoQuest
//
//  Created by Dhiaz Ramadhan on 31/05/24.
//

import Foundation
import SwiftUI

class StreakController: ObservableObject {
    @Published private(set) var currentStreak: Int = 0
    private let defaults = UserDefaults.standard
    private let lastPlayDateKey = "lastPlayDate"
    private let streakKey = "streak"
    private let wonTodayKey = "wonToday"
    
    init() {
        currentStreak = defaults.integer(forKey: streakKey)
    }
    
    func updateStreakOnWin() {
        let today = Date()
        let calendar = Calendar.current
        
        if let lastPlayDate = defaults.object(forKey: lastPlayDateKey) as? Date {
            if calendar.isDateInToday(lastPlayDate) {
                if defaults.bool(forKey: wonTodayKey) {
                    return
                } else {
                    defaults.set(true, forKey: wonTodayKey)
                    return
                }
            }
            
            if let yesterday = calendar.date(byAdding: .day, value: -1, to: today), calendar.isDate(lastPlayDate, inSameDayAs: yesterday) {
                currentStreak += 1
            } else {
                currentStreak = 0
            }
        } else {
            currentStreak = 0
        }
        
        defaults.set(today, forKey: lastPlayDateKey)
        defaults.set(currentStreak, forKey: streakKey)
        defaults.set(true, forKey: wonTodayKey)
    }
    
    func resetDailyFlags() {
        let today = Date()
        let calendar = Calendar.current
        
        if let lastPlayDate = defaults.object(forKey: lastPlayDateKey) as? Date {
            if !calendar.isDateInToday(lastPlayDate) {
                defaults.set(false, forKey: wonTodayKey)
            }
        } else {
            defaults.set(false, forKey: wonTodayKey)
        }
    }
}
