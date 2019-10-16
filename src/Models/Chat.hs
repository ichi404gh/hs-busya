{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Models.Chat where
    import GHC.Generics
    import Data.Aeson.Types

    data ChatType = Private | Group | Supergroup | Channel deriving Show
    data Chat = Chat {
        id :: Int,
        chat_type :: ChatType,
        title :: Maybe String,
        username :: Maybe String,
        first_name :: Maybe String,
        last_name :: Maybe String
    } deriving (Show, Generic)

    getChatType :: String -> ChatType
    getChatType "private" = Private
    getChatType "group" = Group
    getChatType "supergroup" = Supergroup
    getChatType "channel" = Channel
    getChatType _ = undefined

    instance FromJSON Chat where 
        parseJSON (Object v) = Chat <$>
            v .: "id" <*>
            (getChatType <$> v .: "type") <*>
            v .:? "title" <*>
            v .:? "username" <*>
            v .:? "first_name" <*>
            v .:? "last_name"
        parseJSON _ = mempty