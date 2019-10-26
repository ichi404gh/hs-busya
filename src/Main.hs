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
  mbPortStr <- lookupEnv "PORT"
  return $ fromMaybe 3000 $ mbPortStr >>= readMaybe

getConfigPath :: IO String
getConfigPath = do
  mbConfigPath <- lookupEnv "CONFIGPATH"
  return $ fromMaybe "./settings.ini" mbConfigPath

main :: IO ()
main = do
  port <- getPort
  configPath <- getConfigPath
  configResult <- Config.initConfig configPath
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
