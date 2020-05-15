"use strict";
const SseStream = require('ssestream')

exports.createSseStream = req => () => { new SseStream(req) }

exports.pipe = sse => stream => () => { sse.pipe(stream) }

exports._write = sse => message => () => { sse.write(message) }

exports._writeHead = sse => statusCode => headers => () => { 
  sse.writeHead(statusCode, headers) 
}