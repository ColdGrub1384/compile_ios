//
//  main.swift
//  compile_ios
//
//  Created by Adrian Labbe on 12/31/18.
//  Copyright © 2018 Adrian Labbé. All rights reserved.
//

import Foundation

switch URL(fileURLWithPath: CommandLine.arguments[0]).lastPathComponent {
case "iosxcrun": iosxcrun_main()
case "iosenv": iosenv_main()
case "gfortran": gfortran_main()
default:
    fputs("Unknown program name! Run 'iosxcrun', 'iosenv' or 'gfortran'.\n", stderr)
    exit(1)
}
