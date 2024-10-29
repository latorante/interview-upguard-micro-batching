//
//  main.swift
//  ocr-cli
//
//  Created by Martin Picha on 28/10/2024.
//

import Foundation
import ArgumentParser

struct MicroBatcher: ParsableCommand {
    
    static let configuration = CommandConfiguration(
        abstract: "Run test micro batcher using micro-batching library created for interview process."
    )

    @Argument(help: "Number of Jobs in a batch.")
    var sizeOfBatch: Int = 10
    
    @Argument(help: "Max age in seconds.")
    var maxAge: Int = 15
    
    @Argument(help: "Number of Jobs to create.")
    var numberOfJobsToCreate: Int = 100
    
    func run() {
        // Run microbatching library and print output on the screen
    }
}

MicroBatcher.main()
