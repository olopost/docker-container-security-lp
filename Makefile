

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
	@docker run -p 1313:1313 -ti --name hugo --rm -v $(CURDIR)/orgdocs:/src lp/hugo-builder hugo server -w --bind=0.0.0.0

lint:
	@echo "lint"
	docker run --rm -i -v $(CURDIR):/root  hadolint/hadolint  < Dockerfile

sec:
	@echo "sec check"
	@docker run --rm -i -v $(CURDIR):/root  projectatomic/dockerfile-lint dockerfile_lint -p -f Dockerfile -r /root/policies/security_rules.yml

check_health:
	@echo "Checking the health of the Hugo Server..."
	@docker inspect --format='{{json .State.Health}}' hugo

.PHONY: build doc serve lint check_health