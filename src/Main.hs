-- {-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import System.Environment
import Text.Read (readMaybe)
import Data.Maybe
import Models.Update
import Control.Monad.IO.Class
import UpdateProcessor
import qualified Config

getPort :: IO Int
getPort = do
  mbPortStr <- lookupEnv "PORT" :: IO (Maybe String)
  return $ fromMaybe 3000 $ mbPortStr >>= readMaybe
  

main :: IO ()
main = do
  port <- getPort
  configResult <- Config.config
  case configResult of
    Left s -> error s
    Right config -> 
      scotty port $ do

        post "/:token" $ do
          update <- jsonData :: ActionM Update
          resp <- liftIO $ processUpdate config update
          maybe (text "OK") json resp

        notFound $ do
          html $ "<h3>woopsy~doopsy</h3>"
