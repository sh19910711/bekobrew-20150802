.PHONY: all test

all: bekobrew installer

bekobrew: tmp/bekobrew

tmp/bekobrew: src/bekobrew.sh src/bekobrew/*.sh
	./script/build_bekobrew

gh-pages: installer

installer: tmp/install.sh

tmp/install.sh: src/installer.sh
	./script/build_installer

publish_bekobrew: tmp/bekobrew
	./script/travis/publish_bekobrew

publish_installer: tmp/installer.sh
	./script/travis/publish_installer

test: bekobrew
	find test/ -name test_*.sh -exec bash {} \;
