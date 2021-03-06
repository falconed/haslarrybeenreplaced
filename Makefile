CURRENT_COMMIT=$(shell git rev-list --max-count=1 HEAD)

all: site

site:
	git submodule update
	hugo --theme=artists

server: site
	hugo server --theme=artists --buildDrafts

publish: all
	git status | grep 'nothing to commit'
	git push origin -u master
	git checkout gh-pages
	rm -rf css img js work
	mv public/* .
	rm -r public
	rm -rf themes
	git add *
	git status
	git ci -a -m ${CURRENT_COMMIT}
	git push origin -u gh-pages
	git checkout master

