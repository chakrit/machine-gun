package main

type ErrInternal string

func (e ErrInternal) Error() string {
	return "internal inconsistency: " + string(e)
}
