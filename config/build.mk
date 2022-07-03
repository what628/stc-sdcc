
.PHONY: build_dirs
build_dirs: $(BUILD_DIRS)

.PHONY: $(BUILD_DIRS)
$(BUILD_DIRS):
	@$(MAKE) -C $@ all

# dependencies
%.rel: %.c*
	@echo -e "\t" CC $(CCFLAG) $< -o $@
	@$(CC) $(CCFLAG) $< -o $@
