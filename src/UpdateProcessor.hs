module UpdateProcessor (processUpdate) where
    import Models.Update

    processUpdate :: Update -> IO ()
    processUpdate u = do
    print u
    return ()
    