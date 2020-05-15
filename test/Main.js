"use strict";

exports.writableStreamBuffer = () => {
  var W = require('stream-buffers').WritableStreamBuffer
  return new W
}

exports.contentStr = w => () => {
  return w.getContentsAsString('utf8')
}
