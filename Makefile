# ---------------------------------------------
# Linux Makefile for Web Extension Development
# ---------------------------------------------

# 'build' target compiles and builds the extension
build: install
	@cd popup && npm install && npm run build  # Navigate to 'popup', install dependencies, and build
	@web-ext build  # Build the web extension

# 'dev' target sets up a development environment
dev: install
	tmux new-session 'cd popup; git ls-files | entr npm run build' ';' \
		 split-window 'web-ext run'  # Create a tmux session for live development

# 'install' target installs the native messaging host
install:
	@mkdir -p ~/.mozilla/native-messaging-hosts  # Create directory for native messaging host
	@for f in helper/*; do \
		sed "s#@HOME@#$$HOME#" $$PWD/$$f > ~/.mozilla/native-messaging-hosts/$$(basename $$f) ; \
		chmod u+x ~/.mozilla/native-messaging-hosts/yt_dlp_firefox ; \
	done  # Install the native messaging host scripts

# 'uninstall' target removes the native messaging host
uninstall:
	@cd helper; for f in *; do \
		rm -f ~/.mozilla/native-messaging-hosts/$$f ; \
	done  # Remove installed native messaging host scripts

# 'PHONY' targets are used for commands that don't represent files
.PHONY: build dev install uninstall
