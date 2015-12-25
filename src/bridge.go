package main

// #include <stdlib.h>
import "C"
import "unsafe"

//export Free
func Free(ptr unsafe.Pointer) int {
	C.free(ptr)
	return 0
}

//export BridgeCommand
func BridgeCommand(ccmd *C.char, cinput *C.char, coutput **C.char) int {
	cmd := C.GoString(ccmd)
	input := C.GoString(cinput)
	output := Execute(cmd, input)
	*coutput = C.CString(output)
	return 0
}
