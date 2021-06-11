BUILD_DIR = ./build
OPTS= -nostdlib -ffreestanding -mno-red-zone -fno-exceptions -Wall -Wextra
GCC=/usr/local/x86_64elfgcc/bin/x86_64-elf-gcc

all: run

run: kernel.bin
	qemu-system-x86_64 -fda $<

$(BUILD_DIR)/boot.o: src/boot.asm
	@mkdir -p $(BUILD_DIR)
	@nasm -f elf64 $< -o $@

kernel.bin: src/kernel/kernel.c $(BUILD_DIR)/boot.o
	@$(GCC) $^ -o $@ $(OPTS) -T linker.ld

clean: kernel.bin 
	@rm -rf $(BUILD_DIR) $^
