## StrongSwan on Alpine linux

### Configuration
#### init scripts
To run any pre-run scripts before the StrongSwan client is started mount a directory with you scripts to 
`/init-scripts.d`, the start up script will execute through them one by one before starting the client

#### Config
You can mount the StringSwan configuration scripts to the `/etc` directory