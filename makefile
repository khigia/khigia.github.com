.PHONY: run build deploy
run:
	/var/lib/gems/1.8/bin/jekyll --pygments --server

build:
	/var/lib/gems/1.8/bin/jekyll --pygments

deploy:
	rsync \
	  -avzP \
	  --rsh=ssh \
	  --rsync-path=/srv/d_khi/local/bin/rsync \
	  _site/ \
	  admin@khigia.net:/srv/d_khi/www/blog.khigia.net/htdocs/
