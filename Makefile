target=$(basename $(shell ls *.scm))
all: $(target)
$(target): 
	@echo '==================Making $@=============================='
	mit-scheme < $@.scm
test: 
	mit-scheme < test.scm
jmc:
	mit-scheme < jmc.scm

