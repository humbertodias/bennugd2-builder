LINUX_IMG  := bgd2-linux-x64
SWITCH_IMG := bgd2-switch

LINUX_DIR  := linux-x64
SWITCH_DIR := switch-aarch64

.PHONY: all
all: build-linux-x64 build-switch

.PHONY: build-linux-x64
build-linux:
	docker build $(LINUX_DIR) -t $(LINUX_IMG)

.PHONY: build-switch
build-switch:
	docker build $(SWITCH_DIR) -t $(SWITCH_IMG)

.PHONY: run-linux-x64
run-linux:
	docker run --rm -it $(LINUX_IMG)

.PHONY: run-switch
run-switch:
	docker run --rm -it -v "$(PWD)":/workspace -w /workspace $(SWITCH_IMG)

.PHONY: clean
clean:
	docker rmi -f $(LINUX_IMG) $(SWITCH_IMG) || true

.PHONY: help
help:
	@echo "Makefile commands for BennuGD2 Docker:"
	@echo "  make build-linux-x64 - Build Linux 64-bit Docker image"
	@echo "  make build-switch    - Build Nintendo Switch Docker image"
	@echo "  make run-linux-x64   - Run Linux container interactively"
	@echo "  make run-switch      - Run Switch container interactively (mounts current dir)"
	@echo "  make clean           - Remove built images"
	@echo "  make all             - Build both images"
