IMAGE_PREFIX = hldtux/bennugd2

build/linux32:
	docker build linux-i386 -t $(IMAGE_PREFIX)-linux32

build/linux64:
	docker build linux-x86_64 -t $(IMAGE_PREFIX)-linux64

build/switch:
	docker build switch-aarch64 -t $(IMAGE_PREFIX)-switch

build: build-linux32 build-linux64 build-switch

deploy/linux32:
	docker push $(IMAGE_PREFIX)-linux32

deploy/linux64:
	docker push $(IMAGE_PREFIX)-linux64

deploy/switch:
	docker push $(IMAGE_PREFIX)-switch

deploy: deploy-linux32 deploy-linux64 deploy-switch

clean:
	docker rmi -f $(IMAGE_PREFIX)-linux32 $(IMAGE_PREFIX)-linux64 $(IMAGE_PREFIX)-switch || true
