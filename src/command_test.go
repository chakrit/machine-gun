package main

import "testing"

func TestWrapError(t *testing.T) {
	e := ErrInternal("test error")
	result := WrapError(e)
	if result.Code != "ErrInternal" {
		t.Error("wrong error code returned.")
	} else if result.Error != e.Error() {
		t.Error("wrong error message returned.")
	}
}
