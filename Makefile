BUILD_DIR = ./build

CC=gcc
CFLAGS=-fno-pie -g -ffreestanding -m32 
ASM=nasm
LINKER=ld


all: run

run: image.bin
	qemu-system-i386 -fda $<

$(BUILD_DIR)/boot.bin: src/boot.asm
	@mkdir -p $(BUILD_DIR)
	$(ASM) -f bin $< -o $@

clean: 
	@rm -rf bin
