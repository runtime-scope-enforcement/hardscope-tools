#!/usr/bin/make -f

RISCVCC=$(RISCV)/bin/riscv32-unknown-elf-gcc

RISCV_CFLAGS=-Xassembler -march=rv32imxscen -mxscen -fplugin=$(PLUGIN) -DHAVE_XSCEN_V2
RISCV_GCC_BARE_LNK_OPTS=-Tbare/bare.ld -Lbare -nostdlib -static
RISCV_GCC_PULPINO_LNK_OPTS=-Tbare/pulpino/pulpino.ld -Ibare/pulpino -nostdlib -static

GCC_HEADERS=$(RISCV)/lib/gcc/riscv32-unknown-elf/6.1.0/plugin/include/

PLUGINDIR=./gcc-plugin
PLUGIN=$(PLUGINDIR)/scen.so

TESTDIR=./tests
TESTS=$(notdir $(basename $(wildcard $(TESTDIR)/test_*.c)))

PULPINO_MALLOC=bare/pulpino/malloc.c bare/pulpino/malloc_x.S

.PHONY: test_targets
test_targets:
	echo $(TESTS)
	echo $(wildcard $(TESTDIR)/testhelp_*.[Scs])
	
.PHONY: tests
tests: $(addprefix $(TESTDIR)/, $(addsuffix .o, $(TESTS)))

$(TESTDIR)/test_%-pulpino.s: $(TESTDIR)/test_%.c
	$(RISCVCC) -mxscen -fplugin=$(PLUGIN) -Xassembler -march=rv32ixscen -S $(RISCV_GCC_PULPINO_LNK_OPTS) -o $@ $<

$(TESTDIR)/test_%.disas: $(TESTDIR)/test_%.bin
	riscv-disas.sh $< >$@

$(TESTDIR)/test_%.trace: $(TESTDIR)/test_%.bin
	spike-pulp --xscen=2 $< 2>/dev/null 1>$@
	spike-pulp --xscen=2 $< 2>>$@       1>/dev/null

$(TESTDIR)/test_%-pulpino.bin: $(TESTDIR)/test_%.c bare/pulpino/crt0-pulpino.S
	$(RISCVCC) $(RISCV_CFLAGS) $(RISCV_GCC_PULPINO_LNK_OPTS) -o $@ $^ $(wildcard $(basename $(subst test_,testhelp_,$<)).[Scs])

$(TESTDIR)/test_%.bin: $(TESTDIR)/test_%.c
	$(RISCVCC) $(RISCV_CFLAGS) $(RISCV_GCC_BARE_LNK_OPTS) -o $@ $< bare/syscalls.S -lgcc

$(TESTDIR)/test_%.o: $(TESTDIR)/test_%.s
	$(RISCVCC) $(RISCV_CFLAGS) -o $@ $< -static $(wildcard $(basename $(subst test_,testhelp_,$<)).[Scs])

$(TESTDIR)/test_%.s: $(TESTDIR)/test_%.c
	$(RISCVCC) $(RISCV_CFLAGS) -S -o $@ $<

$(PLUGIN): $(PLUGINDIR)/scen.o
	$(CXX) -std=c++11 -ggdb -shared -o $@ $<

$(PLUGINDIR)/scen.o: $(PLUGINDIR)/scen.cpp $(PLUGINDIR)/scen.h
	$(CXX) -std=c++11 -ggdb -fno-rtti -fPIC -Wall -I$(GCC_HEADERS) -c -o $@ $<

# Disable built-in rules
.SUFFIXES: 

.PHONY: clean
clean:
	rm -f $(TESTDIR)/test_*/test_*.c.*r.*
	rm -f $(TESTDIR)s/test_*/test_*.c.*t.*
	rm -f $(TESTDIR)/test_*/test_*.c.*i.*
	rm -f $(TESTDIR)/test_*.s tests/test_*.o
