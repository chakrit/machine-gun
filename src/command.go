package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"reflect"
)

type Command interface {
	Execute() (interface{}, error)
}

type ErrorResult struct {
	Code  string `json:"code"`
	Error string `json:"error"`
}

func WrapError(e error) *ErrorResult {
	return &ErrorResult{
		reflect.TypeOf(e).Name(),
		e.Error(),
	}
}

// Since even errors are serialized to JSON, JSON marshal errors mustn't happen, ever.
func Execute(command, input string) (result string) {
	defer func() {
		if r := recover(); r != nil {
			var err *ErrorResult
			if e, ok := r.(error); ok {
				err = WrapError(e)
			} else {
				err = WrapError(errors.New(fmt.Sprint(r)))
			}

			if bytes, e := json.Marshal(err); e != nil {
				panic(e) // Wrap(ed)Error should always be easily serializable.
			} else {
				result = string(bytes)
			}
		}
	}()

	var cmd Command = nil
	switch command {
	case "ping":
		cmd = &PingCommand{}
	case "start":
		cmd = &StartCommand{}
	case "request":
		cmd = &RequestCommand{}
	case "response":
		cmd = &ResponseCommand{}
	case "stop":
		cmd = &StopCommand{}

	default:
		panic(ErrInternal("invalid command: " + command))
	}

	if e := json.Unmarshal([]byte(input), cmd); e != nil {
		panic(ErrInternal("bad json input: " + input))
	}

	out, e := cmd.Execute()
	if e != nil {
		panic(e)
	}

	bytes, e := json.Marshal(out)
	if e != nil {
		panic(ErrInternal("output not json-compatible: " + e.Error()))
	}

	return string(bytes)
}
