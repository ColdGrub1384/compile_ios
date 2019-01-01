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
        
        guard argument != "-arch" else {
            if CommandLine.arguments.indices.contains(i+1), CommandLine.arguments[i+1] == "arm64" {
                arguments.append(argument)
            }
            continue
        }
        
        guard argument != "x86_64" else {
            continue
        }
        
        arguments.append(argument)
    }
    
    RunExecutable(atPath: "/usr/bin/xcrun", withArguments: arguments)
}
