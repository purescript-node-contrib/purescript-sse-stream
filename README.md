# purescript-sse-stream
Stream for writing Server-Sent Events  

## Installation

***This library is not yet published to pursuit.***  
You can install this package by adding it to your packages.dhall:

```dhall
let additions =
  { sse-stream =
      { dependencies =
        [ "http-types"
        , "node-http"
        , "node-streams"
        , "spec"
        ]
      , repo =
          "https://github.com/purescript-node-contrib/purescript-sse-stream.git"
      , version =
          "master"
      }
  }
```
```console
user@user:~$ spago install sse-stream
```

## Usage (**Under Construction**)