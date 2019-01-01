//
//  RunCommand.swift
//  compile_ios
//
//  Created by Adrian Labbe on 1/1/19.
//  Copyright © 2019 Adrian Labbé. All rights reserved.
//

import Foundation

/// Runs command.
///
/// - Parameters:
///     - path: The path of the executable to run.
///     - arguments: Arguments passed excluding the executable name.
///     - standardOutput: `Pipe` or `FileHandle` that receives the output.
///     - standardError: `Pipe` or `FileHandle` that receives the errors.
///     - standardInput: `Pipe` or `FileHandle` for writting input.
///
/// - Returns: The exit code.
@discardableResult func RunExecutable(atPath path: String, withArguments arguments: [String] = [], standardOutput: Any? = FileHandle.standardOutput, standardError: Any? = FileHandle.standardError, standardInput: Any? = FileHandle.standardInput) -> Int {
    
    let executable = URL(fileURLWithPath: path)
    
    let p = Process()
    if #available(OSX 10.13, *) {
        p.executableURL = executable
    } else {
        p.launchPath = executable.path
    }
    p.arguments = arguments
    p.standardOutput = standardOutput
    p.standardError = standardError
    p.standardInput = standardInput
    
    if #available(OSX 10.13, *) {
        do {
            try p.run()
        } catch {
            fputs(error.localizedDescription+"\n", stderr)
        }
    } else {
        p.launch()
    }
    
    p.waitUntilExit()
    
    return Int(p.terminationStatus)
}
