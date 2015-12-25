package main

import (
	"encoding/json"
)

type PingCommand map[string]interface{}

type PingResult struct {
	Pong string `json:"pong"`
}

func (cmd *PingCommand) Execute() (interface{}, error) {
	bytes, e := json.Marshal(cmd)
	if e != nil {
		return nil, e
	}

	return &PingResult{string(bytes)}, nil
}
