module Test.Main where

import Prelude

import Control.Plus (empty)
import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (launchAff_, makeAff, nonCanceler)
import Effect.Class (liftEffect)
import Node.Stream (Writable)
import Node.Stream as Stream
import SSE as SSE
import SSE.Types (ServerEvent(..))
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (runSpec)

foreign import writableStreamBuffer :: Effect (Writable ())

foreign import contentStr :: Writable () -> Effect String 

main :: Effect Unit
main = launchAff_ $ runSpec [consoleReporter] do
  describe "SseStream" do
      it "writes multiple multiline messages" do
        let msg1 = ServerEvent { data: "hello\nworld", id: empty, event: empty }
            msg2 = ServerEvent { data: "こんにちは\n世界", id: empty, event: empty }

        sse  <- liftEffect $ SSE.createSseStream_
        sink <- liftEffect $ writableStreamBuffer

        _ <- liftEffect $ SSE.pipe sse sink 

        _ <- liftEffect $ SSE.write sse msg1 
        _ <- liftEffect $ SSE.write sse msg2 
        _ <- liftEffect $ SSE.end sse 

        result  <- makeAff \done -> do 
              Stream.onFinish sink do
                content <- contentStr sink
                done $ Right content
              pure nonCanceler

        let expected = """:ok

data: hello
data: world

data: こんにちは
data: 世界

"""
        result `shouldEqual` expected