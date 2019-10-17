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
Port is optional, default is `3000`

Then, set a [webhook](https://core.telegram.org/bots/webhooks). If you run on desktop, you need https tunnel, like [ngrok](https://ngrok.com/).
