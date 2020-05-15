"use strict";
const SseStream = require('ssestream').default

exports.createSseStream = req => () => { return new SseStream(req) }

exports.createSseStream_ = () => { return new SseStream() }

exports.pipe = sse => stream => () => { sse.pipe(stream) }

exports._write = sse => message => () => { sse.write(message) }
// exports._writeMessage = sse => message => cb => () => { sse.write(message,) }
exports._writeHead = sse => statusCode => headers => () => { 
  sse.writeHead(statusCode, headers) 
}

exports.end = sse => () => { sse.end() }