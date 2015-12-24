package main

import "C"

//export Hello
func Hello(cinput *C.char) *C.char {
	input := C.GoString(cinput)
	return C.CString("Hello, " + input)
}

func main() { /*no-op*/ }
