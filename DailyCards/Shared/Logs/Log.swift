//
//  Log.swift
//  DailyCards
//
//  Created by Jobson on 27/05/25.
//


import Foundation

class Log {
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()

    private static func timestamp() -> String {
        return dateFormatter.string(from: Date())
    }

    static func info(_ message: String) {
        print("\(timestamp()) [INFO] \(message)")
    }

    static func error(_ message: String) {
        print("\(timestamp()) [ERROR] \(message)")
    }
}
