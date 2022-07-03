# tools.
CC = sdcc
PACKIHX = packihx

LED_BLINK_DELAY ?= 1000

# out.
TARGET ?= main

BUILD_DIR = build
OUTPUT_DIR = output
TGT_OUTPUT_DIR = $(OUTPUT_DIR)/$(TARGET)
EXEC = $(BUILD_DIR)/$(TARGET).ihx
out_hex	= $(TGT_OUTPUT_DIR)/$(TARGET).hex

C_DEFINE = \
-DLED_BLINK_DELAY=$(LED_BLINK_DELAY)

C_SOURCES =  \
main.c \
src/led.c \
src/uart_proc.c

# C includes
C_INCLUDES =  \
-Iinclude \

# input.
OBJ = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:%c=%rel)))
vpath %.c $(sort $(dir $(C_SOURCES)))
# SRC = $(wildcard *.c)
# OBJ = $(addprefix $(BUILD_DIR)/,$(notdir $(SRC:%c=%rel)))
CCFLAG = -c --stack-auto --no-xinit-opt --model-large $(C_INCLUDES) $(C_DEFINE)
LDFLAG = --stack-auto --no-xinit-opt --model-large $(C_INCLUDES)

all:$(out_hex)

$(out_hex):$(EXEC) | $(TGT_OUTPUT_DIR)
	$(PACKIHX) $< > $@

$(EXEC):$(OBJ) | $(BUILD_DIR)
	$(CC) $(LDFLAG) $(OBJ) -o $@

$(BUILD_DIR)/%.rel:%.c | $(BUILD_DIR)
	$(CC) $(CCFLAG) $(<) -o $(@)

$(BUILD_DIR):
	mkdir $@

$(TGT_OUTPUT_DIR):
	mkdir -p $(TGT_OUTPUT_DIR)

.PHONY : allclean

allclean:
	-rm -rf $(BUILD_DIR) $(TGT_OUTPUT_DIR)
