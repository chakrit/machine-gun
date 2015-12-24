package main

// #include <stdlib.h>
import "C"
import "unsafe"

//export Free
func Free(ptr unsafe.Pointer) int {
	C.free(ptr)
	return 0
}

// Hello functions for testing the GO<->RB bridge.

// export BridgeCommand
func BridgeCommand(ccmd *C.char, cinput *C.char, coutput **C.char) int {

}

//export Hello
func Hello(cinput *C.char, coutput **C.char) int {
	input := C.GoString(cinput)
	result := "Hello, " + input
	*coutput = C.CString(result)
	return 0
}

//export HelloArray
func HelloArray(cinputs_ptr **C.char, cinputs_ptr_len int, coutputs_ptr ***C.char, coutputs_ptr_length *int) int {
	const MaxLen = 255
	var _c_char_ptr *C.char

	cinput_ptr := uintptr(unsafe.Pointer(cinputs_ptr))
	buffer := make([]string, 0, MaxLen)

	for i := 0; i < cinputs_ptr_len; i++ {
		cinput := *(**C.char)(unsafe.Pointer(cinput_ptr))
		buffer = append(buffer, C.GoString(cinput))
		cinput_ptr += unsafe.Sizeof(_c_char_ptr)
	}

	for i, str := range buffer {
		buffer[i] = "Hello, " + str
	}

	output_size := C.size_t(int(unsafe.Sizeof(_c_char_ptr)) * len(buffer))
	*coutputs_ptr = (**C.char)(C.malloc(output_size))
	*coutputs_ptr_length = len(buffer)

	coutput_ptr := uintptr(unsafe.Pointer(*coutputs_ptr))
	for _, str := range buffer {
		*(**C.char)(unsafe.Pointer(coutput_ptr)) = C.CString(str)
		coutput_ptr += unsafe.Sizeof(_c_char_ptr)
	}

	return 0
}
