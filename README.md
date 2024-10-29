# Micro Batcher

`micr-batcher` is a test implementation of Micro Batching library.

## Build

```
# Build & test
swift build
.build/debug/micro-batcher
```


## Results

### Batching library time out

Send 1000 jobs to the batching library, by 10 per batch, with 1 second timeout.

```
swift build && .build/debug/micro-batcher 10 1 1000
```
