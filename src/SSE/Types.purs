module SSE.Types where

import Data.Maybe (Maybe)

newtype EventName  = EventName String 

data ServerEvent 
  = Comment String 
  | RetryEvent Int 
  | ServerEvent { event :: Maybe EventName 
                , id    :: Maybe String 
                , data  :: String 
                } 

foreign import data SseStream :: Type