#!/usr/bin/env jq -rMf

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
  "receive"
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
        (.response.headers[] | select(.name == "content-type").value),
        (.response.headers[] | select(.name == "content-length").value),
        (.response.headers[] | select(.name == "cache-control").value),
        .time,
        .timings.blocked,
        .timings.dns,
        .timings.connect,
        .timings.ssl,
        .timings.send,
        .timings.wait,
        .timings.receive
      ]
	)
  # output in CSV format
  | @csv
