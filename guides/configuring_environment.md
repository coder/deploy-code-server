# Configure code-server and environemnt
### Changing START_DIR in [entrypoint.sh](/deploy-container/entrypoint.sh) or getting Directory '/home/coder/poject' does not exist
If you change the directory and now code-server wont work, or if you are getting errors containg the starting directory that say it doesnt exist, you can add the following command into the Dockerfile to create the starting directory
```Dockerfile
# Create starting directory
# Should be the same as $START_DIR in entrypoint.sh
RUN mkdir /home/coder/project
```
___
### Using a config.yaml file for code-server
code-server will automatically generate a configuration file [[Source]](https://github.com/cdr/code-server/blob/main/docs/FAQ.md#how-does-the-config-file-work)<br>
You can create a config.yaml file in the deploy-container directory containing your code-server configuration.<br>
Afterwards, in order for it to be used, you will need to add these Docker commands to the Dockerfile
```Dockerfile
# Create config directory
RUN mkdir /home/coder/.config

# Copy config file
# The path to the file bing copied should be the same as where you created the config file
COPY deploy-container/config.yaml /home/coder/.config/code-server/config.yaml
```
Now you can edit entrypoint.sh and change the last line to
```shell
# Now we can run code-server with the default entrypoint
# The path to the config file should be where it was copied to
/usr/bin/entrypoint.sh --config /home/coder/.config/code-server/config.yaml --bind-addr 0.0.0.0:8080 $START_DIR
```
Or you can set the CODE_SERVER_CONFIG environment variable to the path of your configuration file<br>
For more information about this, see [cdr/code-server/main/docs/FAQ.md](https://github.com/cdr/code-server/blob/main/docs/FAQ.md#how-does-the-config-file-work)
___
### Changing the default vscode settings that get applied each time the container is rebuilt
You can simply edit deploy-container/settings.json to your vscode settings. When the container gets rebuilt, they will be copied to the appropriate place and be applied in code-server.<br>
> NOTE: These settings are applied User-wide
