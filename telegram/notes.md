# telegram

## Get Updates
```bash
token='' # Get from BotFather
curl https://api.telegram.org/bot{$token}/getUpdates
```

## Send Message
```bash
token='' # Get from BotFather
chat_id='' # Get from getUpdates
message=''
curl -s -X POST https://api.telegram.org/bot{$token}/sendMessage -d chat_id=$chat_id -d text="$message"
```