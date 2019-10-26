# hs-busya

Busya implementation in haskell.

### Requirements
Install [Stack](https://docs.haskellstack.org/en/stable/README/#how-to-install)
### Build
```
$ stack build
```
### Run for development
```
$ PORT=1234 stack run hsbot
```

Then, set a [webhook](https://core.telegram.org/bots/webhooks). If you run on desktop, you need https tunnel, like [ngrok](https://ngrok.com/).

### Params
All params are passed as environment args.

#### `PORT`
Port for listening. Default is `3000`

#### `CONFIGPATH`
Path to config file. Default is `./settings.ini`. Exmaple config file is `settings.ini.example` at the root of repo. Config file is reading once when program started. You need to restart bot after config is changed.
