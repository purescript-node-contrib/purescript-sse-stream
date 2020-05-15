module SSE.Types where

import Data.Maybe (Maybe)

data ServerEvent 
  = Comment String 
  | RetryEvent Int 
  | ServerEvent { event :: Maybe String 
                , id    :: Maybe String 
                , data  :: String 
                } 

foreign import data SseStream :: Type