.PHONY: default build
default: build

node_modules: package.json
	npm install

test: node_modules
	npm test

build:  node_modules
	npm build
  

clean:
	git clean -fdX
