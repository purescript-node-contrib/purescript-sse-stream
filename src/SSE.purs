module SSE 
  ( createSseStream
  , pipe 
  , write
  , writeHead
  )
  where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Foreign.Object (Object)
import Foreign.Object as Object
import Network.HTTP.Types as H
import Node.HTTP.Client as HTTP
import Node.Stream (Writable)
import SSE.Types (ServerEvent(..), SseStream)

writeHead :: SseStream -> H.Status -> Array H.Header -> Effect Unit
writeHead sse {code, message} hdrs = _writeHead sse code headers
  where 
    headers = Object.fromFoldable hdrs 
  
write :: SseStream -> ServerEvent -> Effect Unit 
write sse (Comment comment) =  _write sse { comment }
write sse (RetryEvent retry) =  _write sse { retry }
write sse (ServerEvent {data: d, event: e, id: i}) = case d,e,i of  
  _data,Nothing,Nothing    -> _write sse { data: _data }
  _data,Just event,Just id -> _write sse { data: _data, event, id }
  _data,Just event,Nothing -> _write sse { data: _data, event }
  _data,Nothing,Just id    -> _write sse { data: _data, id }

-- TO CONSIDER: since the SseStream object extends Transform class 
-- and Transform is simply a duplex, should we return a Duplex type instead?
foreign import createSseStream :: HTTP.Request -> Effect SseStream
foreign import pipe :: forall r. SseStream -> Writable r -> Effect (Writable r)
foreign import _write :: forall message. SseStream -> { | message } -> Effect Unit  
foreign import _writeHead :: SseStream -> Int -> Object String -> Effect Unit