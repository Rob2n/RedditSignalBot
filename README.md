# Setup account
#### Don't really remember how I set it up but you just want a working signal-cli to extract the config folder in the end :)
### New account
* Register account: `signal-cli -u <phone number> register --voice`<br/>
    Format of `<phone number>` (w/o spaces): `+<country code><phone number>`
* Wait for the phone call to get `<code>`
* Verify account: `signal-cli -u <phone number> verify <code>`<br/>
    Now the key material is stored in the home directory
### Existing account
* Link your existing account: `signal-cli -u <phone number> link`<br/>
    Generate a plaintext QRcode of the output link online and scan it with the Signal app
## Then
* **Copy config folder for reuse with docker:** `cp -R ~/.local/share/signal-cli/ ./docker/signal_config`

# Setup `RedditSignalBot`
* Customize the crontab in `./docker/crontab`
    https://crontab.guru/ serves as a small aid
* Customize the messaging script in `./docker/send_message.sh`
* Build docker container: `docker build -t RedditSignalBot--no-cache`
* Start docker container: `docker run --rm -it RedditSignalBot`

    **OR**

* Fork this repo, connect it to https://render.com, and deploy on Free tier "Web Service"

  *The project includes a useless Flask web service in order to pass the render.com healthchecks and get this to deploy OK*
