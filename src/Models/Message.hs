{-# LANGUAGE DeriveGeneric #-}
module Models.Message where
    import GHC.Generics
    import Data.Aeson.Types
    import Models.User
    import Models.Chat


    data Message = Message {
        message_id :: Int,
        from :: Maybe User,
        chat :: Chat,
        text :: Maybe String,
        new_chat_members :: Maybe [User],
        left_chat_member :: Maybe User
    } deriving (Show, Generic)

    instance FromJSON Message