# Makefile for HiFive1 RevB RISC-V Lab 2 Project

# Toolchain
CC = riscv64-unknown-elf-gcc
AS = riscv64-unknown-elf-as
LD = riscv64-unknown-elf-ld
OBJCOPY = riscv64-unknown-elf-objcopy

# Flags
CFLAGS = -march=rv32imac -mabi=ilp32 -O2 -Wall -Isrc
ASFLAGS = -march=rv32imac -mabi=ilp32
LDFLAGS = -T link.ld

# Source files
C_SOURCES = src/main.c src/gpio.c
ASM_SOURCES = src/gpio.S
OBJECTS = $(C_SOURCES:.c=.o) $(ASM_SOURCES:.S=.o)

# Target
TARGET = lab2

.PHONY: all clean

all: $(TARGET).bin

$(TARGET).elf: $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $< $@

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.S
	$(AS) $(ASFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJECTS) $(TARGET).elf $(TARGET).bin

install: $(TARGET).bin
	# Upload to HiFive1 RevB board (requires appropriate upload tool)
	@echo "Upload $(TARGET).bin to HiFive1 RevB board"