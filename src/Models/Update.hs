{-# LANGUAGE DeriveGeneric #-}
module Models.Update where
    import GHC.Generics
    import Data.Aeson.Types
    import Models.Message

    data Update = Update {
        update_id :: Int,
        message :: Maybe Message
    } deriving (Show, Generic)

    instance FromJSON Update
