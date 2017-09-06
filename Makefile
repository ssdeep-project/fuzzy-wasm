CLANG  = clang
CFLAGS = -std=gnu11 -O3 -ffreestanding
TARGET = wasm32
all: fuzzy-wasm.wasm
fuzzy-wasm.wasm: fuzzy-wasm.wast
	wasm-as -o $@ $<
fuzzy-wasm.wast: fuzzy-wasm.s
	s2wasm -o $@ $<
fuzzy-wasm.s: fuzzy-wasm.bc
	llc -o $@ $<
fuzzy-wasm.bc: fuzzy-wasm.c sum_table.h musl-libc.h
	$(CLANG) $(CFLAGS) -emit-llvm --target=$(TARGET) -c -o $@ fuzzy-wasm.c
clean:
	rm -f fuzzy-wasm.wasm fuzzy-wasm.wast fuzzy-wasm.s fuzzy-wasm.bc
.PHONY: all clean
