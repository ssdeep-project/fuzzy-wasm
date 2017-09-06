fuzzy-wasm: ssdeep demonstration library for WebAssembly
=========================================================

This library is intended for demo of fuzzy hashing on web browser
which runs WebAssembly. It has slight modifications from the original
ssdeep (version 2.14):

*	Built-in libc functions
*	Minimum dependencies to libc to minimize wasm file size
*	Stateful APIs for zero dynamic memory allocation
*	Some variables made global
	(because it cannot access local variables through pointers)

## Build Requirements

*	LLVM and Clang 5.0 or later (with WebAssembly experimental backend)

## API Differences

*	`fuzzy_new` does not return context and other APIs don't have
	`struct fuzzy_state*` typed argument.
*	`fuzzy_set_total_input_length` have two length arguments
	(high half and low half) because we cannot provide 64-bit integer
	arguments from JavaScript.
*	Temporary buffer intended for digests are pre-allocated.
	Its address can be retrieved from `fuzzy_wasm_get_temp_buffer` and
	slot count and size per slot can be retrieved from
	`fuzzy_wasm_get_temp_buffer_count` and
	`fuzzy_wasm_get_temp_buffer_slot_size` functions.
	Note that the size per slot is barely enough for digests with no
	file names. So, you need to care about buffer size.

## Files (including generated ones)

*	`fuzzy-wasm.c`, `sum_table.h`  
	Slightly modified ssdeep 2.14 source code
*	`musl-libc.h`  
	Part of musl libc <https://www.musl-libc.org/>
*	`fuzzy-wasm.wast`  
	WebAssembly AST
*	`fuzzy-wasm.wasm`  
	WebAssembly module (in binary format)
