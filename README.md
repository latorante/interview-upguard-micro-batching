# Micro Batcher

`micro-batcher` is a test implementation of Micro Batching library, which is added as a dependency in the project. The library is used to batch jobs and process them in batches.

The dependency is defined in the `Package.swift` file as `.package(url: "https://github.com/latorante/interview-upguard-micro-batching-library", .branch("main"))`. 

This project just uses the library and enables - displays it's functionality.

## Prerequisites

- Swift 5.2.4
- Xcode 11.5

```sh
# Install Swift
brew install swift
```

## Build

You can build the cli by the below command (the clean command is there as we don't use micr-batcher version for package, but main repository')

```
swift package clean && swift build 
```

This creates a binary in the `.build/debug` directory. You can use this binary then with arguments passed.

```
.build/debug/micro-batcher 10 1 1000
```

## Arguments

Running `.build/debug/micro-batcher --help` gives you all possible arguments for the CLI tool and their explamanation.

```
OVERVIEW: Run test micro batcher using micro-batching library created for interview process.

USAGE: micro-batcher [<size-of-batch>] [<frequency>] [<number-of-jobs-to-create>] [<timeout>]

ARGUMENTS:
  <size-of-batch>         Number of Jobs in a batch. Must be greater than 0. (default: 10)
  <frequency>             Frequency of batches in seconds. Must be greater than 0. (default: 15)
  <number-of-jobs-to-create>
                          Number of Jobs to create. Greater than 0. (default: 100)
  <timeout>               Timeout for job submission in seconds. Must be greater than 0. (default: 1)

OPTIONS:
  -h, --help              Show help information.

```

## Results testing

### Batching library batch size and frequency

Send 1000 jobs to the batching library, by 10 per batch, with 1 second frequency.

```
.build/debug/micro-batcher 10 1 1000
```

Send 30 jobs to the batching library, by 10 per batch, with 1 second frequency.

```
.build/debug/micro-batcher 10 3 30
```

## Other

### SimpleBatchProcessor: BatchProcessor

This is just a sample class and not a full implementation, ideally this class would handle timeouts and other edge cases as well. Not in a scope of this exercise.

## Example output

```
.build/debug/micro-batcher 5 1 15 1
micro-batchibg: [2024-10-30 02:51:08 +0000] Job 1 completed
micro-batchibg: [2024-10-30 02:51:08 +0000] Job 2 completed
micro-batchibg: [2024-10-30 02:51:08 +0000] Job 3 completed
micro-batchibg: [2024-10-30 02:51:08 +0000] Job 4 completed
micro-batchibg: [2024-10-30 02:51:08 +0000] Job 5 completed
micro-batching: Processed batch with results: [MicroBatching.JobResult(result: Optional("Job 1 completed"), error: nil), MicroBatching.JobResult(result: Optional("Job 2 completed"), error: nil), MicroBatching.JobResult(result: Optional("Job 3 completed"), error: nil), MicroBatching.JobResult(result: Optional("Job 4 completed"), error: nil), MicroBatching.JobResult(result: Optional("Job 5 completed"), error: nil)]
micro-batchibg: [2024-10-30 02:51:09 +0000] Job 6 completed
micro-batchibg: [2024-10-30 02:51:09 +0000] Job 7 completed
micro-batchibg: [2024-10-30 02:51:09 +0000] Job 8 completed
micro-batchibg: [2024-10-30 02:51:09 +0000] Job 9 completed
micro-batchibg: [2024-10-30 02:51:09 +0000] Job 10 completed
micro-batching: Processed batch with results: [MicroBatching.JobResult(result: Optional("Job 6 completed"), error: nil), MicroBatching.JobResult(result: Optional("Job 7 completed"), error: nil), MicroBatching.JobResult(result: Optional("Job 8 completed"), error: nil), MicroBatching.JobResult(result: Optional("Job 9 completed"), error: nil), MicroBatching.JobResult(result: Optional("Job 10 completed"), error: nil)]
micro-batchibg: [2024-10-30 02:51:10 +0000] Job 11 completed
micro-batchibg: [2024-10-30 02:51:10 +0000] Job 12 completed
micro-batchibg: [2024-10-30 02:51:10 +0000] Job 13 completed
micro-batchibg: [2024-10-30 02:51:10 +0000] Job 14 completed
micro-batchibg: [2024-10-30 02:51:10 +0000] Job 15 completed
micro-batching: Processed batch with results: [MicroBatching.JobResult(result: Optional("Job 11 completed"), error: nil), MicroBatching.JobResult(result: Optional("Job 12 completed"), error: nil), MicroBatching.JobResult(result: Optional("Job 13 completed"), error: nil), MicroBatching.JobResult(result: Optional("Job 14 completed"), error: nil), MicroBatching.JobResult(result: Optional("Job 15 completed"), error: nil)]
micro-batchibg: All jobs have been processed.
```
