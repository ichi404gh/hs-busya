{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import System.Environment
import Text.Read (readMaybe)
import Data.Maybe
import Models.Update
import Control.Monad.IO.Class
import UpdateProcessor

getPort :: IO Int
getPort = do
  mbPortStr <- lookupEnv "PORT" :: IO (Maybe String)
  return $ fromMaybe 3000 $ mbPortStr >>= readMaybe
  

main :: IO ()
main = do
  port <- getPort
  scotty port $ do

    post "/:token" $ do
      update <- jsonData :: ActionM Update
      resp <- liftIO $ processUpdate update
      case resp of
        Nothing -> text "OK"
        Just j -> json j

    notFound $ do
      html $ "<h3>woopsy~doopsy</h3>"
