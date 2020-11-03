<<<<<<< HEAD
.PHONY: default build
default: build
=======
.PHONY: default node_modules build test deploy

default: test build deploy
>>>>>>> 52426fda88dcaf53d5c4efe3f58295c46d80d180

node_modules: package.json
	npm install

test: node_modules
	npm test

<<<<<<< HEAD
#build: node_modules
#	npx webpack

build:  node_modules
	npm build
  
=======
build: node_modules
	npx webpack
>>>>>>> 52426fda88dcaf53d5c4efe3f58295c46d80d180

LAMBDAS=$(patsubst dist/%/index.js,%,$(wildcard dist/*/index.js))
deploy: build
	for lambda in $(LAMBDAS); do ./deploy-lambda.sh $$lambda; done

clean:
	git clean -fdX
