# git Personal access tokens
# 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
# sdcc_0703 90days token: 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

# tools.
CC = sdcc
PACKIHX = packihx
export CC

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

# C includes
C_INCLUDES =

# input.
CCFLAG = -c --stack-auto --no-xinit-opt --model-large $(C_INCLUDES) $(C_DEFINE)
LDFLAG = --stack-auto --no-xinit-opt --model-large $(C_INCLUDES)
export CCFLAG LDFLAG

# need to build directorys.
BUILD_DIRS := src
OBJS := 
ALL_OBJS := 

# recursive wildcard
rwildcard=$(foreach d,$(wildcard $(addsuffix *,$(1))),$(call rwildcard,$(d)/,$(2))$(filter $(subst *,%,$(2)),$(d)))

.PHONY: all
all:$(out_hex)

$(out_hex): build_dirs $(OBJS) all_objs $(EXEC) | $(TGT_OUTPUT_DIR)
	$(PACKIHX) $(EXEC) > $@
	@echo "completion" $(OBJS) "222"

# phony funcs
.PHONY: all_objs
all_objs:
	$(eval ALL_OBJS += $(call rwildcard,$(BUILD_DIRS),*.rel))

$(EXEC): $(ALL_OBJS) | $(BUILD_DIR)
	$(CC) $(LDFLAG) $(ALL_OBJS) -o $@

$(BUILD_DIR):
	mkdir $@

$(TGT_OUTPUT_DIR):
	mkdir -p $(TGT_OUTPUT_DIR)

.PHONY : allclean

allclean:
	-rm -rf $(BUILD_DIR) $(TGT_OUTPUT_DIR)

# need to be placed at the end of the file
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
export PROJECT_PATH := $(patsubst %/,%,$(dir $(mkfile_path)))
export MAKE_INCLUDE=$(PROJECT_PATH)/config/build.mk
export SUB_MAKE_INCLUDE=$(PROJECT_PATH)/config/subbuild.mk
export C_INCLUDES += -I$(PROJECT_PATH)/include
include $(MAKE_INCLUDE)
