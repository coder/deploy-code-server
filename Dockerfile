FROM codercom/code-server:latest

USER coder

# Apply VS Code settings
COPY settings.json .local/share/code-server/User/settings.json

# Use bash shell
ENV SHELL=/bin/bash

# Use our custom entrypoint script first
COPY railway-entrypoint.sh /usr/bin/railway-entrypoint.sh
ENTRYPOINT ["/usr/bin/railway-entrypoint.sh"]