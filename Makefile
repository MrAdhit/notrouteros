DATE := $(shell date +%Y.%m.%d)
ISO := build/notrouteros-$(DATE)-x86_64.iso
CACHE_DIR := archlive/airootfs/usr/local/share/pacman-cache
PACKAGES_FILE := archlive/packages.x86_64
NOROS_PACKAGES_FILE := archlive/airootfs/usr/local/share/noros/packages

.PHONY: all iso clean patches cache precache

all: patches precache iso

precache:
	@mkdir -p $(CACHE_DIR)
	sudo pacman -Syw --config archlive/pacman.conf --noconfirm $$(grep -v '^#' $(PACKAGES_FILE) | grep -v '^$$') $$(grep -v '^#' $(NOROS_PACKAGES_FILE) | grep -v '^$$')

cache:
	@mkdir -p archlive/airootfs/usr/local/share/pacman-cache
	@grep -v '^#' archlive/airootfs/usr/local/share/noros/packages | grep -v '^$$' | while read pkg; do \
		find /var/cache/pacman/pkg -name "$${pkg}-[0-9]*" -type f | while read f; do \
			sudo cp -v "$$f" archlive/airootfs/usr/local/share/pacman-cache/; \
		done; \
	done

iso: $(ISO)

patches:
	$(MAKE) -C patches

$(ISO): archlive/profiledef.sh archlive/packages.x86_64 $(wildcard patches/repo/*)
	sudo mkarchiso -vrw /tmp/archiso-tmp -o ./build ./archlive
	sudo chown $(shell id -u):$(shell id -g) ./build/*.iso

clean:
	rm -rf ./build/*.iso
	$(MAKE) -C patches clean
