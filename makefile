BUILD_DIR = ./build
OPTS= -nostdlib -ffreestanding -mno-red-zone -fno-exceptions -Wall -Wextra
GCC=/usr/local/i386elfgcc/bin/i386-elf-gcc
all:

run: os.bin
	qemu-system-i386 -fda $<

$(BUILD_DIR)/boot.o: src/boot.asm
	@mkdir -p $(BUILD_DIR)
	@nasm -f elf32 $< -o $@
$(BUILD_DIR)/incbin.o: src/binaries.asm
	@nasm -f elf32 $< -o $@

os.bin: src/kernel/kernel.c $(BUILD_DIR)/boot.o $(BUILD_DIR)/incbin.o
	@$(GCC) $^ -o $@ $(OPTS) -T linker.ld

clean: os.bin 
	@rm -rf $(BUILD_DIR) $^
