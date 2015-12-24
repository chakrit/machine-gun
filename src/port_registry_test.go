package main

import "testing"

func TestPortRegistry_QueueCommands(t *testing.T) {
	registry := NewPortRegistry(2)
	registry.Set(1, make(Port))
	registry.Set(2, make(Port))
	// should not time-out
}

func TestPortRegistry_SetDelete(t *testing.T) {
	port, registry := make(Port), NewPortRegistry(3)
	defer registry.Close()

	registry.Start()
	registry.Set(1, port)

	result, e := registry.Delete(1)
	switch {
	case e != nil:
		t.Error(e)
	case result != port:
		t.Error("wrong port returned: %#v", result)
	}
}

func TestPortRegistry_InvalidDelete(t *testing.T) {
	registry := NewPortRegistry(3)
	defer registry.Close()

	registry.Start()
	_, e := registry.Delete(1)
	switch e.(type) {
	case nil:
		t.Error("expect an error to be returned.")
	case ErrInternal:
		// ok
	default:
		t.Error("expect returned error to be ErrInternal.")
	}
}
