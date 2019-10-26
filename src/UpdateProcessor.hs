{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module UpdateProcessor where
    import Data.Aeson.Types
    import Models.Update
    import Models.Message
    import qualified Models.Chat as C
    import qualified Config

    type JsonResp = IO (Maybe Value)
    
    processUpdate :: Config.Config -> Update -> JsonResp
    processUpdate cfg Update { 
        message = Just msg @ Message {
            from = Just fromUser, 
            new_chat_members = Just newMembers
        }
    }
        | elem fromUser newMembers = do
            replyToMessage (C.id . chat $ msg) (message_id msg) (getMessage cfg)
                where 
                    getMessage = Config.wMessage . Config.cfWellcome 
    
    processUpdate _ u = do
        print u
        return Nothing
    

    replyToMessage :: Int -> Int -> String -> JsonResp
    replyToMessage chatId messageId txt = do
        print $ "*** replyed to " ++ (show messageId) ++ "[" ++ (show chatId) ++ "]: " ++ txt 
        return $ Just $ object [ 
                "method" .= ("sendMessage" :: String),
                "chat_id" .= chatId,
                "reply_to_message_id" .= messageId,
                "text" .= txt
            ]
