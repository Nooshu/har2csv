# har2csv & har2tsv
Convert a [HTTP Archive (HAR)](http://www.softwareishard.com/blog/har-12-spec/) file to a CSV (or TSV) using [jq](https://stedolan.github.io/jq/). Script heavily inspired by [Google's har2csv](https://github.com/google/har2csv) (which requires node) by [Ayman Farhat](https://github.com/aymanfarhat), and also a passing comment by [Andy Davies](https://twitter.com/andydavies).

The script ignores fields that are not essential for analyzing requests/responses such as content and those that might carry private information such as cookies.

## Usage

### Install and run

```sh
# Install jq
$ brew install jq

# Clone the repo, make sure scripts are executable
$ chmod +x har2csv.jq
$ chmod +x har2tsv.jq

# Run CSV
$ ./har2csv.jq input.har > output.csv

# Run TSV
$ ./har2tsv.jq input.har > output.tsv
```

### Generating a HAR file from a browser session

Example using Chrome:

- Open the Dev Tools panel via Ctrl + Shift + i
- Click the “Network” menu item on the top menu bar of the panel
- The HTTP session is recorded by default, navigate to the pages / resources you're inspecting
- Once ready to export the data, right-click anywhere on the list of items in the Network resource list and select “Save all as HAR with content”

## Extracted log entry fields

| Entry path  | CSV column name |
| ------------- | ------------- |
| pageref  | pageRef |
| startedDateTime  | startedDateTime |
| request.method  | requestMethod |
| request.url  | requestUrl |
| request.httpVersion  | requestHttpVersion |
| request.headerSize  | requestHeaderSize |
| request.bodySize  | requestBodySize |
| response.status  | responseStatus |
| response.content.size  | responseContentSize |
| response.content.compression  | responseContentSizeCompression |
| response.content._transferSize  | responseTransferSize |
| response.headers.name['content-type']  | responseContentType |
| response.headers.name['content-length']  | responseContentLength |
| response.headers.name['cache-control']  | responseCacheControl |
| time  | time |
| timings.blocked  | blocked |
| timings.dns  | dns |
| timings.connect  | connect |
| timings.ssl  | ssl |
| timings.send  | send |
| timings.wait  | wait |
| timings.receive  | receive |
| timings._blocked_queuing  | blockedqueueing |

**Note: Entries that don't match the above fields / paths are not included in the result CSV/TSV files**

## Useful links

* [Google's har2csv](https://github.com/google/har2csv)
* [Download jq](https://stedolan.github.io/jq/download/)
* [Information about HAR file analysis](https://nooshu.github.io/blog/2021/02/03/the-importance-of-internal-system-performance/#har-file-analysis)
* [jq Play](https://jqplay.org/)

## Licence

Unless stated otherwise, the codebase is released under the [MIT License](LICENCE). This
covers both the codebase and any sample code in the documentation.
