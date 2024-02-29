VERSION ?= 1.0.0
NAME := thj-wiki.web.app

.PHONY: server
server:
	@hugo server
.PHONY: build
build: 
	@#rm -rf public/*
	@hugo -b https://thj-wiki.web.app/
relogin:
	firebase logout
	firebase login
	firebase use xackery
deploy: build
	@firebase deploy
set-version:
	@echo "VERSION=${VERSION}" >> $$GITHUB_ENV

.PHONY: scss
scss:
	@(echo "/* This file is autogenerated via 'make scss'. DO NOT EDIT */" > static/css/tpe-scss.css)
	docker run --rm -v $(PWD):$(PWD) -w $(PWD) jbergknoff/sass scss/app.scss >> static/css/tpe-scss.css