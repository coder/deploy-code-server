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
___
### directory '/home/coder/.config/rclone' does not exist
If you are getting this error, you can add this command to your Dockerfile
```Dockerfile
# Create rclone config directory
RUN mkdir /home/coder/.config/rclone
```
If you are getting "directory '/home/coder/.config' does not exist", see above for how to create the .config directory or add the -p flag to create any non-existant parent directories as well
___
### Installing extensions
> NOTE: not all extensions maybe available in code-server, see [[1]](https://github.com/cdr/code-server/blob/main/docs/FAQ.md#differences-compared-to-vs-code), [[2]](https://github.com/cdr/code-server/blob/main/docs/FAQ.md#how-can-i-request-a-missing-extension), [[3]](https://github.com/cdr/code-server/blob/main/docs/FAQ.md#how-do-i-configure-the-marketplace-url), and [[4]](https://github.com/cdr/code-server/blob/main/docs/FAQ.md#where-are-extensions-stored) for more info

There are several ways to install extensions
1. Installing directly in code-server<br>
You can install extensions directly from inside code-server using the GUI. The button should be in the activity bar on the left and looks like this
![Extensions Button](/img/vscode-activity-bar-extension-button.png)<br>
You can also use Ctrl+Shift+X to bring it up
> NOTE: Extensions installed using this method will not persist between container rebuilds

2. Installing using vscode integrated terminal<br>
You can install extensions by using the built-in terminal in code-server. Use Ctrl+J to bring up the panel and select the terminal tab. Or you can use Ctrl+\`<br>
The command for installing extensions is:
```shell
code-server --install-extension ms-python.python
# or to install multiple
code-server --install-extension ms-python.python --install-extension redhat.vscode-yaml
```
> NOTE: Extensions installed using this method will not persist between container rebuilds

3. Installing in entrypoint.sh<br>
You can add this command before or after the last line in entrypoint.sh to automatically install extensions in between container rebuilds
```shell
/usr/bin/entrypoint.sh --install-extension ms-python.python
# or to install multiple
/usr/bin/entrypoint.sh --install-extension ms-python.python --install-extension redhat.vscode-yaml
# alternate method to install multiple
/usr/bin/entrypoint.sh --install-extension ms-python.python
/usr/bin/entrypoint.sh --install-extension redhat.vscode-yaml
```
#### Installing before vs after launching code-server.<br>
If you install the extensions before running code-server, then you will need to wait for the installation process to finish before you are able to use code-server. During this time, you will get 502 Bad Gateway.<br>
<br>
If you install after running code-server, you will be able to use code-server but will need to refresh to use extensions after they are installed.
> NOTE: While technically extensions installed using this method will NOT PERSIST bewtween container rebuilds, they will automatically be reinstalled
<br>

> NOTE: These extensions are installed User-wide
