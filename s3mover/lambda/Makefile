.PHONY: default build
default: build

node_modules: package.json
	npm install

test: node_modules
	npm test

#build: node_modules
#	npx webpack

build:  node_modules
	npm build
  

LAMBDAS=$(patsubst dist/%/index.js,%,$(wildcard dist/*/index.js))
deploy: build
	for lambda in $(LAMBDAS); do ./deploy-lambda.sh $$lambda; done

clean:
	git clean -fdX
