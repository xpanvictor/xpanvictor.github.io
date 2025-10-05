# Makefile for Jekyll Blog

# Variables
BUNDLE = bundle
SERVE_CMD = $(BUNDLE) exec jekyll serve
INSTALL_CMD = $(BUNDLE) install --path vendor/bundle

.PHONY: setup serve clean

# Install all dependencies locally into vendor/bundle
setup:
	$(INSTALL_CMD)

# Run the local development server
serve:
	$(SERVE_CMD)

# Remove installed gems (reset environment)
clean:
	rm -rf vendor/bundle .bundle

