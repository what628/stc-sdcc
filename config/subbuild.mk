.PHONY: all
all: $(OBJS) build_dirs

.PHONY: clean
clean: clean-subdirs
	@echo CLEAN $(OBJS)
	@rm -f $(OBJS)

include $(MAKE_INCLUDE)