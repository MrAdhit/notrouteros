# Find all directories containing a PKGBUILD (excluding .disabled directories)
PATCH_DIRS := $(shell find . -maxdepth 2 -name PKGBUILD -exec dirname {} \; | grep -v '\.disabled$$')
REPO_DIR := ../archlive/airootfs/usr/local/share/noros/repo

.PHONY: all $(PATCH_DIRS) clean repo update-repo

all: $(PATCH_DIRS) update-repo

$(PATCH_DIRS):
	cd $@ && makepkg -Lf

update-repo:
	@mkdir -p $(REPO_DIR)
	@find $(PATCH_DIRS) -maxdepth 1 -name '*.pkg.tar.*' -exec cp -v {} $(REPO_DIR)/ \;
	repo-add $(REPO_DIR)/patches.db.tar.gz $(REPO_DIR)/*.pkg.tar.*

clean:
	@for dir in $(PATCH_DIRS); do \
		echo "Cleaning $$dir..."; \
		cd $$dir && rm -rf pkg src *.pkg.tar.* *.log *.log.* && cd ..; \
	done
	rm -rf $(REPO_DIR)
