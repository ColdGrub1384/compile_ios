//
//  sdkPath.swift
//  compile_ios
//
//  Created by Adrian Labbe on 12/31/18.
//  Copyright © 2018 Adrian Labbé. All rights reserved.
//

import Foundation

/// Returns the iOS sdk path.
var sdkPath: String = {
    var sdkPath: String?
    
    let sdkPipe = Pipe()
    sdkPipe.fileHandleForReading.readabilityHandler = { handle in
        if let str = String(data: handle.availableData, encoding: .utf8)?.replacingOccurrences(of: "\n", with: ""), FileManager.default.fileExists(atPath: str) {
            sdkPath = str
        }
    }
    
    let findSDK = RunExecutable(atPath: "/usr/bin/xcrun", withArguments: ["--sdk", "iphoneos", "--show-sdk-path"], standardOutput: sdkPipe)
    
    guard findSDK == 0, sdkPath != nil else {
        fputs("Cannot find SDK!\n", stderr)
        exit(1)
    }
    
    return sdkPath!
}()
