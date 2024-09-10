#!/usr/bin/jq -rMf

# Quickly convert a HTTP Archive file (har) to a CSV file.

# Headers for resulting CSV file
[
  "pageRef",
  "startedDateTime",
  "requestMethod",
  "requestUrl",
  "requestHttpVersion",
  "requestHeaderSize",
  "requestBodySize",
  "responseStatus",
  "responseContentSize",
  "responseContentSizeCompression",
  "responseTransferSize",
  "responseContentType",
  "responseContentLength",
  "responseCacheControl",
  "time",
  "blocked",
  "dns",
  "connect",
  "ssl",
  "send",
  "wait",
  "receive",
  "blockedqueueing"
],
  (
    # drill down into the entries data
    .log.entries
    # convert object into array and extract the value
    | to_entries[].value
    # pull out the data we want in the CSV
    | [
        .pageref,
        .startedDateTime,
        .request.method,
        .request.url,
        .request.httpVersion,
        .request.headersSize,
        .request.bodySize,
        .response.status,
        .response.content.size,
        .response.content.compression,
        .response._transferSize,
        (.response.headers[] | select(.name | match("content-type";"i")).value),
        (.response.headers[] | select(.name | match("content-length";"i")).value),
        (.response.headers[] | select(.name | match("cache-control";"i")).value),
        .time,
        .timings.blocked,
        .timings.dns,
        .timings.connect,
        .timings.ssl,
        .timings.send,
        .timings.wait,
        .timings.receive,
        .timings["_blocked_queueing"]
      ]
	)
  # output in CSV format
  | @csv
