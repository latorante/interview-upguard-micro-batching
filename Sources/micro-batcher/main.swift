//
//  main.swift
//  ocr-cli
//
//  Created by Martin Picha on 28/10/2024.
//

import Foundation
import ArgumentParser
import MicroBatching

/// A simple command-line tool to run a test micro batcher using the micro-batching library.
struct MicroBatcher: ParsableCommand {
    
    static let configuration = CommandConfiguration(
        abstract: "Run test micro batcher using micro-batching library created for interview process."
    )

    @Argument(help: "Number of Jobs in a batch. Must be greater than 0.")
    var sizeOfBatch: Int = 10
    
    @Argument(help: "Frequency of batches in seconds. Must be greater than 0.")
    var frequency: Int = 15
    
    @Argument(help: "Number of Jobs to create. Greater than 0.")
    var numberOfJobsToCreate: Int = 100
    
    @Argument(help: "Timeout for job submission in seconds. Must be greater than 0.")
    var timeout: Int = 1
    
    /// Validate the input arguments
    func validate() throws {
        if (numberOfJobsToCreate < 1){
            throw ValidationError("Number of Jobs to create must be greater than 0.")
        }
        if (frequency < 1){
            throw ValidationError("Jobs must run at least for a second.")
        }
        if (sizeOfBatch < 1){
            throw ValidationError("Batch size must be greater than 0.")
        }
        if (timeout < 1) {
            throw ValidationError("Timeout must be greater than 0 seconds.")
        }
    }
    
    func run() {
        // Step 1: Create a configuration for micro-batching
        let config = MicroBatchingConfig(batchSize: sizeOfBatch, batchFrequency: TimeInterval(frequency))
        
        // Step 2: Create an instance of your batch processor
        let batchProcessor = SimpleBatchProcessor(timeout: timeout) // Replace with your actual implementation

        // Step 3: Create the MicroBatching instance
        let microBatching = MicroBatching(config: config, batchProcessor: batchProcessor)
        
        // We need to make sure the Task runs and the main thread doesn't exit
        // on us, so we use a DispatchGroup to wait for the Task to finish.
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        Task {
            for i in 1...numberOfJobsToCreate {
                let job: Job = {
                    // Simulating some work with sleep
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
    let timeout: Int
    
    public init(timeout: Int) {
        // TODO: Ideally the batch processor would implement the time out as well.
        self.timeout = timeout
    }
    
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
