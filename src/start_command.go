package main

import (
	"net/http"
)

type StartCommand struct{}

func (cmd *StartCommand) Execute() (interface{}, error) {
	client = &http.Client{}
	counter = Counter(0)
	registry = NewPortRegistry(8)
	registry.Start()
	return nil, nil
}
