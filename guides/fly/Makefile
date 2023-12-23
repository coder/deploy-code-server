
OS_NAME=$(shell uname)

FLYCTL_BIN_NAME=flyctl
ifeq ($(shell uname),Windows)
	FLYCTL_BIN_NAME=flyctl.exe
endif
FLYCTL_BIN_WHICH=$(shell which $(FLYCTL_BIN_NAME))

# Variables for fly deployment
FLY_APP_NAME=joeblow-code-server
FLY_APP_NAME_DB=$(FLY_APP_NAME)-postres
FLY_APP_REGION=lhr

PG_CONNECTION_URL=DATABASE_URL=postgres://joeblow_code_server:utH7QQvcleHd7Mn@gedw99-code-server-postres.flycast:5432/joeblow_code_server?sslmode=disable

print:
	@echo ""
	@echo "OS_NAME:             $(OS_NAME)"
	@echo ""
	@echo "FLYCTL_BIN_NAME:     $(FLYCTL_BIN_NAME)"
	@echo "FLYCTL_BIN_WHICH:    $(FLYCTL_BIN_WHICH)"
	@echo ""

	@echo "FLY_APP_NAME:            $(FLY_APP_NAME)"
	@echo "FLY_APP_NAME_DB:         $(FLY_APP_NAME_DB)"
	@echo ""
	@echo "PG_CONNECTION_URL:   $(PG_CONNECTION_URL)"
	@echo ""

0-deploy-setup:
	# install the fly ctl tooling locally...
	# see: https://fly.io/docs/hands-on/install-flyctl

ifeq ($(shell uname),Windows)
	pwsh -Command "iwr https://fly.io/install.ps1 -useb | iex"
endif
ifeq ($(shell uname),Darwin)
	brew install flyctl
endif
ifeq ($(shell uname),Linux)
	brew install flyctl
endif


1-deploy-auth:
	# signup or login. Its manages both...
	flyctl auth signup
2-deploy-list:
	flyctl apps list
	flyctl postgres list
3-deploy-create:
	flyctl postgres create --name $(FLY_APP_NAME_DB)
	flyctl apps create --name $(FLY_APP_NAME)
	flyctl postgres attach --app $(FLY_APP_NAME) $(FLY_APP_NAME_DB)
	# copy PG_CONNECTION_URL to Makefile...
4-deploy-secrets:
	flyctl secrets set CODER_PG_CONNECTION_URL=$(PG_CONNECTION_URL) --app $(FLY_APP_NAME)
5-deploy-run:
	flyctl deploy --app $(FLY_APP_NAME)
6-deploy-update:
	#  it will pull the latest version of Coder and deploy it.
	flyctl deploy --app $(FLY_APP_NAME)
7-deploy-scale:
	# scale to 1 gb memory if oyu want.
	flyctl scale memory 1024 --app $(FLY_APP_NAME)
8-deploy-sentry:
	# capture erros
	# https://fly.io/docs/reference/sentry/
	flyctl ext sentry create
9-deploy-sentry-ls:
	# opens the sentry web gui to list and errors ...
	flyctl apps errors
10-deploy-destroy:
	# deletes the app ...
	flyctl postgres detach --app $(FLY_APP_NAME) $(FLY_APP_NAME_DB)
	flyctl apps destroy $(FLY_APP_NAME)
	flyctl apps destroy $(FLY_APP_NAME_DB)