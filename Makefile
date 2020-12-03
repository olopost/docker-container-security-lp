

default: build

build:
	@echo "Building Hugo Builder container..."
	@docker build -t lp/hugo-builder .
	@echo "Hugo Builder container built!"
	@docker images lp/hugo-builder


doc:
	@echo "Building doc"
	@docker run -ti --rm -v $(CURDIR)/orgdocs:/src lp/hugo-builder hugo

serve:
	@echo "serve doc on http://localhost:1313"
	@docker run -p 1313:1313 -ti --rm -v $(CURDIR)/orgdocs:/src lp/hugo-builder hugo server -w --bind=0.0.0.0

lint:
	@echo "lint"
	@docker run --rm -i -v $(CURDIR):/root  hadolint/hadolint  < Dockerfile

.PHONY: build doc serve lint
