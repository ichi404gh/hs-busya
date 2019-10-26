module Config where
    import Data.Ini.Config
    import qualified Data.Text.IO as DTIO


    data Config = Config {
        cfWellcome :: WellcomeConfig
    } deriving (Eq, Show)

    data WellcomeConfig = WellcomeConfig {
        wMessage :: String
    } deriving (Eq, Show)

    configParser :: IniParser Config
    configParser = do
        wellcomeCf <- section "WELLCOME" $ do
            messageFld <- fieldOf "message" string
            return WellcomeConfig { wMessage = messageFld }
        return Config { cfWellcome = wellcomeCf }


    config :: IO (Either String Config)
    config = do
        settingsFile <- DTIO.readFile "./settings.ini"
        let eitherCfg = parseIniFile settingsFile Config.configParser
        return eitherCfg
        