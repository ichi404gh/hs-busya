{-# LANGUAGE DeriveGeneric #-}
module Models.User where
    import GHC.Generics
    import Data.Aeson.Types

    data User = User {
        id :: Int,
        is_bot :: Bool,
        first_name :: String,
        last_name :: Maybe String,
        username :: Maybe String
    } deriving (Show, Generic)

    instance FromJSON User