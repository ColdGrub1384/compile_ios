//
//  ios_environment.swift
//  compile_ios
//
//  Created by Adrian Labbe on 12/31/18.
//  Copyright © 2018 Adrian Labbé. All rights reserved.
//

import Foundation

// MARK: - Find SDK path

/// Opens a shell with environment for compilling projects for iOS
func iosenv_main() {
    
    guard let iosxcrun = Bundle.main.path(forResource: "iosxcrun", ofType: nil) else {
        fputs("Cannot find 'iosxcrun' executable.\n", stderr)
        exit(1)
    }
    
    let environment = [
        "CC" : "\(iosxcrun) clang -isysroot \(sdkPath) -arch arm64",
        "CXX" : "\(iosxcrun) clan++ -isysroot \(sdkPath) -arch arm64",
        
        "ARCHFLAGS" : "-arch arm64",
        "CFLAGS" : "-arch arm64 -isysroot \(sdkPath)",
        "CPPFLAGS" : "-arch arm64 -isysroot \(sdkPath)",
        "LDFLAGS" : "-arch arm64 -isysroot \(sdkPath)",
        
        "IPHONEOS_DEPLOYMENT_TARGET" : "8.0",
        
        "_PYTHON_HOST_PLATFORM" : "iphoneos-arm64",
    ]
    
    for (key, value) in environment {
        print("\(key)=\(value)")
        setenv(key, value, 1)
    }
    
    print("\nYou can now compile a C project for iOS from this subshell.\n")
    
    execv("/bin/bash", nil)
}
