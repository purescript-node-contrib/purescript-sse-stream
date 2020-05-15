{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "sse-stream"
, dependencies =
  [ "console"
  , "effect"
  , "http-types"
  , "node-http"
  , "node-streams"
  , "psci-support"
  , "spec"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
