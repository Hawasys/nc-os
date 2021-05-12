BUILD_DIR = ./buil
ASM=nasm
OPTS=-m64 -nostdlib -ffreestanding -mno-red-zone -fno-exceptions -nostdlib -Wall -Wextra -Werror
all: run

run: image.bin
	qemu-system-x86_64 -fda $<

$(BUILD_DIR)/boot.bin: src/boot.asm
	@mkdir -p $(BUILD_DIR)
	$(ASM) -f bin $< -o $@

$(BUILD_DIR)/extendedboot.o: src/extendedboot.asm
	@mkdir -p $(BUILD_DIR)
	$(ASM) -f elf64 $< -o $@

$(BUILD_DIR)/kernel.o: src/kernel/kernel.c
	x86_64-elf-gcc $(OPTS) $< -o $@ 

$(BUILD_DIR)/kernel.bin: $(BUILD_DIR)/extendedboot.o $(BUILD_DIR)/kernel.o
	x86_64-elf-ld -T linker.ld -shared -ffreestanding -nostdlib -fno-pie -o $@ -Ttext 0x7e00 $^ 
	 
image.bin: $(BUILD_DIR)/boot.bin $(BUILD_DIR)/kernel.bin
	@cat $^ > image.bin
	
clean: $(BUILD_DIR) image.bin 
	@rm -rf $(BUILD_DIR) $^
