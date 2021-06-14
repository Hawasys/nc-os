BUILD_DIR = ./build
OPTS= -nostdlib -ffreestanding -mno-red-zone -fno-exceptions -Wall -Wextra
GCC=/usr/local/i386elfgcc/bin/i386-elf-gcc
all:

run: kernel.bin
	qemu-system-i386 -fda $<

$(BUILD_DIR)/boot.o: src/boot.asm
	@mkdir -p $(BUILD_DIR)
	@nasm -f elf32 $< -o $@

kernel.bin: src/kernel/kernel.c $(BUILD_DIR)/boot.o
	@$(GCC) $^ -o $@ $(OPTS) -T linker.ld

clean: kernel.bin 
	@rm -rf $(BUILD_DIR) $^
