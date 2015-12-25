package main

import (
	"io/ioutil"
)

type ResponseCommand struct {
	ID uint64 `json:"id"`
}

type ResponseResult struct {
	StatusCode int                 `json:"status_code"`
	Headers    map[string][]string `json:"headers"`
	Payload    string              `json:"payload"`
}

func (cmd *ResponseCommand) Execute() (interface{}, error) {
	port, e := registry.Delete(cmd.ID)
	if e != nil {
		return nil, e
	}

	data := <-port
	response, e := data.Response, data.Error
	if e != nil {
		return nil, e
	}

	result := &ResponseResult{
		StatusCode: response.StatusCode,
		Headers:    response.Header,
	}

	if response.Body != nil {
		defer response.Body.Close()
		bytes, e := ioutil.ReadAll(response.Body)
		if e != nil {
			return nil, e
		}

		result.Payload = string(bytes)
	}

	return result, nil
}
