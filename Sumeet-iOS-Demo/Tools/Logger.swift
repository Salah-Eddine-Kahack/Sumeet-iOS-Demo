//
//  Logger.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 07/04/2025.
//

import Foundation



struct Logger {

    enum LogLevel: String {
        case warning = "WARNING"
        case error = "ERROR"
        case debug = "DEBUG"
    }

    static func log(_ message: String,
                    level: LogLevel = .debug,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {

        let timestamp = DateFormatter.localizedString(
            from: Date(),
            dateStyle: .none,
            timeStyle: .medium
        )
        
        let thread = Thread.isMainThread ? "Main" : "Background"
        let logMessage = "[\(timestamp)] [\(level.rawValue)] [\(thread)] \(message) (\(file):\(line) in \(function))"

        if level == .debug {
            #if DEBUG
                print(logMessage)
            #endif
        }
        else {
            print(logMessage)
        }
    }
}
