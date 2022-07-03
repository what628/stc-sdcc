OBJS := $(patsubst %.c, %.rel,$(wildcard *.c))
BUILD_DIRS := $(shell ls -l | grep ^d | awk '{print $$9}')

include $(SUB_MAKE_INCLUDE)