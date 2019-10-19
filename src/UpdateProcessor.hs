{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module UpdateProcessor where
    import Data.Aeson.Types
    import Models.Update
    import Models.Message
    import qualified Models.Chat as C
    
    type JsonResp = IO (Maybe Value)
    
    processUpdate :: Update -> JsonResp
    processUpdate Update { 
        message = Just msg @ Message {
            from = Just fromUser, 
            new_chat_members = Just newMembers
        }
    }
        | elem fromUser newMembers = do
            replyToMessage (C.id $ chat msg) (message_id msg) "wellcome" 
    
    processUpdate u = do
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
