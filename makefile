BUILD_DIR = ./build

ASM=nasm

all: run

run: image.bin
	qemu-system-x86_64 -fda $<

$(BUILD_DIR)/boot.bin: src/boot.asm
	@mkdir -p $(BUILD_DIR)
	$(ASM) -f bin $< -o $@

$(BUILD_DIR)/extendedboot.bin: src/extendedboot.asm
	@mkdir -p $(BUILD_DIR)
	$(ASM) -fbin $< -o $@

image.bin: $(BUILD_DIR)/boot.bin $(BUILD_DIR)/extendedboot.bin
	@cat $^ > image.bin

clean: 
	@rm -rf $(BUILD_DIR)
