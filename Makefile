.PHONY: all test clean

all: bekobrew installer


bekobrew: tmp/bekobrew/bekobrew

tmp/bekobrew/bekobrew: script/build_bekobrew src/bekobrew/bekobrew.bash src/bekobrew/sub_command/*.bash
	./script/build_bekobrew


installer: tmp/installer/install.bash

tmp/installer/install.bash: script/build_installer src/installer/install.bash
	./script/build_installer

publish_bekobrew: tmp/bekobrew/bekobrew
	./script/travis/publish_bekobrew

publish_installer: tmp/installer/install.bash
	./script/travis/publish_installer


gh-pages: installer

test: bekobrew
	find test/ -name test_*.sh -exec bash {} \;

clean:
	rm -rf tmp/

