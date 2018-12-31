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
    
    let findSDK = Process()
    let xcrun = URL(fileURLWithPath: "/usr/bin/xcrun")
    if #available(OSX 10.13, *) {
        findSDK.executableURL = xcrun
    } else {
        findSDK.launchPath = xcrun.path
    }
    findSDK.arguments = ["--sdk", "iphoneos", "--show-sdk-path"]
    findSDK.standardOutput = sdkPipe
    if #available(OSX 10.13, *) {
        do {
            try findSDK.run()
        } catch {
            fputs(error.localizedDescription, stderr)
            exit(1)
        }
    } else {
        findSDK.launch()
    }
    findSDK.waitUntilExit()
    
    guard findSDK.terminationStatus == 0, sdkPath != nil else {
        fputs("Cannot find SDK!\n", stderr)
        exit(1)
    }
    
    return sdkPath!
}()
