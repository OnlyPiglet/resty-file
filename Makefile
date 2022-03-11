## init: make same init work
.PHONY: init
init:
	@commitizen init cz-conventional-changelog --save --save-exact

## changelog: generate changelog
.PHONY: changelog
changelog:
	@conventional-changelog -p angular -i CHANGELOG.md -w -r 0 > ./CHANGELOG.md

## help: show help info.
.PHONY: help
help: Makefile
	@echo -e "\nUsage: make <TARGETS> <OPTIONS> ...\n\nTargets:"
	@sed  -n 's/^##//p' $< | column -t -s ':' | sed -e 's/^/ /'
	@echo "$$USAGE_OPTIONS"

## commit: git commit
.PHONY: commit
commit:
	@git cz

## deploy: deploy this module to luarock.org
.PHONY: deploy
deploy:
	@luarocks upload resty-file-dev-1.rockspec --api-key=$(LUAROCKAPIKEY) --force