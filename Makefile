target=$(basename $(shell ls *.scm))
all: $(target)
$(target): 
	@echo '==================Making $@=============================='
	mit-scheme < $@.scm

