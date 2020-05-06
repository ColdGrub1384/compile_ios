//
//  gfortran.swift
//  compile_ios
//
//  Created by Adrian Labbé on 06-05-20.
//  Copyright © 2020 Adrian Labbé. All rights reserved.
//

import Foundation

func gfortran_main() {
    var arguments = [String]()
    
    for (i, argument) in CommandLine.arguments.enumerated() {
        
        guard i != 0 else {
            continue
        }
        
        guard argument != "f95" else {
            arguments.append("f95")
            continue
        }
        
        arguments.append(argument)
    }
        
    RunExecutable(atPath: "/usr/bin/clang", withArguments: arguments)
}
