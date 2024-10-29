//
//  main.swift
//  ocr-cli
//
//  Created by Martin Picha on 28/10/2024.
//

import Foundation
import ArgumentParser
import MicroBatching

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
        // Step 1: Create a configuration for micro-batching
        let config = MicroBatchingConfig(batchSize: sizeOfBatch, batchTimeout: TimeInterval(maxAge))
        
        // Step 2: Create an instance of your batch processor
        let batchProcessor = SimpleBatchProcessor() // Replace with your actual implementation

        // Step 3: Create the MicroBatching instance
        let microBatching = MicroBatching(config: config, batchProcessor: batchProcessor)
        
        // We need to make sure the Task runs and the main thread doesn't exit
        // on us, so we use a DispatchGroup to wait for the Task to finish.
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        // Step 4: Create and submit the jobs
        Task {
            for i in 1...numberOfJobsToCreate {
                let job: Job = {
                    // Simulating some work with sleep
                    Thread.sleep(forTimeInterval: 1) // Simulate processing time
                    return JobResult(result: "Job \(i) completed", error: nil) // Return a result
                }
                await microBatching.submit(job: job) // Use 'await' for actor method
            }

            // Step 5: Shutdown the micro-batching system after all jobs are submitted
            await microBatching.shutdown()
            print("micro-batchibg: All jobs have been processed.")
            dispatchGroup.leave() // Leave the dispatch group when done
        }
        dispatchGroup.wait()
    }
}

/// Sample Batch Processer implementation using the BatchProcessor protocol
/// from the micro-batching library.
struct SimpleBatchProcessor: BatchProcessor {
    func process(batch: [Job]) -> [JobResult] {
        // Process each job and collect results
        var results: [JobResult] = []
        for job in batch {
            let result = job() // Execute the job
            results.append(result) // Collect the result
            // Print timestamp and completion message
            if let jobResult = result.result {
                let timestamp = Date()
                print("micro-batchibg: [\(timestamp)] \(jobResult)") // Print the completion message with timestamp
            } else if let error = result.error {
                print("micro-batchibg: error: \(error)")
            }
        }
        return results // Return all results
    }
}

MicroBatcher.main()
