# BennuGD2 Builder

Docker containers to build **BennuGD2** for multiple platforms, including Linux and Nintendo Switch.

## Build Docker Images

You can build the images for the supported platforms either with Docker commands:

```bash
make build-linux-x64
make build-switch
make all
```

## Usage

### Run Linux BennuGD2

```bash
make run-linux-x64
```

### Run Switch BennuGD2

Mount your current directory as `/workspace` to build NRO files:

```bash
make run-switch
```

## Clean up

Remove the built Docker images:

```bash
make clean
```

## Help

For a summary of Makefile commands:

```bash
make help
```
