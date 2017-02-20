all: index.html

index.html: $(shell find src tests -type f -name '*.elm' -o -name '*.js')
	elm-make src/App.elm --yes --debug --warn --output=$@
	elm-test
