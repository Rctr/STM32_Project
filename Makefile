# Makefile dla STM32F4xx

# Nazwa projektu
TARGET = stm32_project

# Ścieżki
CORE_DIR = Core
SRC_DIR = $(CORE_DIR)/Src
INC_DIR = $(CORE_DIR)/Inc
DRIVERS_DIR = Drivers
HAL_DIR = $(DRIVERS_DIR)/STM32F4xx_HAL_Driver
CMSIS_DIR = $(DRIVERS_DIR)/CMSIS

# Kompilator i narzędzia
CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy
OBJDUMP = arm-none-eabi-objdump
SIZE = arm-none-eabi-size

# MCU
MCU = cortex-m4

# FPU
FPU = -mfpu=fpv4-sp-d16
FLOAT-ABI = -mfloat-abi=hard

# Flagi kompilatora
CFLAGS = -mcpu=$(MCU) -mthumb $(FPU) $(FLOAT-ABI)
CFLAGS += -DUSE_HAL_DRIVER -DSTM32F401xE
CFLAGS += -I$(INC_DIR)
CFLAGS += -I$(HAL_DIR)/Inc
CFLAGS += -I$(HAL_DIR)/Inc/Legacy
CFLAGS += -I$(CMSIS_DIR)/Device/ST/STM32F4xx/Include
CFLAGS += -I$(CMSIS_DIR)/Include
CFLAGS += -Os -Wall -fdata-sections -ffunction-sections

# Flagi linkera
LDFLAGS = -mcpu=$(MCU) -mthumb $(FPU) $(FLOAT-ABI)
LDFLAGS += -specs=nano.specs -specs=nosys.specs
LDFLAGS += -T STM32F401RETx_FLASH.ld
LDFLAGS += -Wl,--gc-sections -static --specs=nano.specs
LDFLAGS += -Wl,--start-group -lc -lm -Wl,--end-group
LDFLAGS += -Wl,-Map=$(TARGET).map,--cref

# Pliki źródłowe
SOURCES = $(SRC_DIR)/main.c
SOURCES += $(SRC_DIR)/stm32f4xx_it.c
SOURCES += $(SRC_DIR)/system_stm32f4xx.c

# Pliki obiektowe
OBJECTS = $(SOURCES:.c=.o)

# Domyślny cel
all: $(TARGET).elf $(TARGET).hex $(TARGET).bin
	$(SIZE) $(TARGET).elf

# Kompilacja plików .c do .o
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Linkowanie
$(TARGET).elf: $(OBJECTS)
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@

# Generowanie pliku .hex
$(TARGET).hex: $(TARGET).elf
	$(OBJCOPY) -O ihex $< $@

# Generowanie pliku .bin
$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary -S $< $@

# Czyszczenie
clean:
	rm -f $(OBJECTS) $(TARGET).elf $(TARGET).hex $(TARGET).bin $(TARGET).map

# Flash przez st-link
flash: $(TARGET).hex
	st-flash --format ihex write $<

# Debug
debug: $(TARGET).elf
	arm-none-eabi-gdb $<

.PHONY: all clean flash debug