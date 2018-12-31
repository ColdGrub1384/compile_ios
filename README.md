# compile_ios

This command line program for Mac sets needed environment variables for compilling a C project for iOS arm64.

## Requirements

macOS 10.9+ with Xcode and command line tools installed.

## Installation

    $ ./install.sh
    
This will install the command.

## Usage

    $ iosenv
    
`iosenv` command will open a shell, you can then build a C project from it for iOS. 

Projects wil not magically compile! This is just a helper, you will probably need to modify some environment variables to include other Header Search Paths.

## Build result

iOS arm64 (iPhone 5S+, iPad Air+, iPod Touch 6G) binaries. Not for iOS simulator!

## Tested with

- NumPy
- Pandas
