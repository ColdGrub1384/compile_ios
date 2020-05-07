//
//  compile.swift
//  compile_ios
//
//  Created by Adrian Labbe on 12/31/18.
//  Copyright © 2018 Adrian Labbé. All rights reserved.
//

import Foundation

/// Filters arguments and pass them to `xcrun` to exclude Mac architecture.
func iosxcrun_main() {
    var arguments = [String]()
    
    for (i, argument) in CommandLine.arguments.enumerated() {
        
        guard i != 0 else {
            continue
        }
        
        guard argument != "f95" else {
            arguments.append("c")
            continue
        }
        
        guard argument != "-arch" else {
            if CommandLine.arguments.indices.contains(i+1), CommandLine.arguments[i+1] == "arm64" {
                arguments.append(argument)
            }
            continue
        }
        
        guard argument != "-isysroot" else {
            if CommandLine.arguments.indices.contains(i+1) {
                arguments.append(argument)
                arguments.append(sdkPath)
            }
            continue
        }
        
        guard argument != "x86_64" else {
            continue
        }
        
        guard argument != "-bundle" else {
            arguments.append("-dynamiclib")
            continue
        }
        
        if argument.contains("MacOSX.platform") {
            continue
        }
        
        if argument.hasPrefix("-mmacosx-version-min=") {
            continue
        }
        
        if (URL(fileURLWithPath: argument)).pathExtension == "sdk" {
            guard arguments.indices.contains(i-1) && arguments[i-1] == "-isysroot" else {
                print("Ignored alone SDK Path")
                continue
            }
            print("SDK Path detected")
        }
        
        if argument == "-framework" {
            if CommandLine.arguments.indices.contains(i+1), CommandLine.arguments[i+1] == "Cocoa" {
                continue
            }
        }
        
        if argument == "Cocoa" {
            if CommandLine.arguments.indices.contains(i-1), CommandLine.arguments[i-1] == "-framework" {
                continue
            }
        }
        
        arguments.append(argument)
    }
    
    print("Command: xcrun \(arguments.joined(separator: " "))")
    
    RunExecutable(atPath: "/usr/bin/xcrun", withArguments: arguments)
}
