export GOFLAGS := -mod=mod

.PHONY: sync-network-data verify-footer-override clean

sync-network-data:
	cp vendor/network-manifest/network.json data/network.json

verify-footer-override: sync-network-data
	hugo --gc --minify -d public_check
	grep -F "AngryMichigander Network" public_check/index.html
	grep -E 'href="?https://dinokent\.com"?' public_check/index.html
	rm -rf public_check

clean:
	rm -rf public public_check
