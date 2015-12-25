package main

import (
	"io/ioutil"
	"net/http"
	"net/url"
	"strings"
)

type RequestCommand struct {
	Method  string              `json:"method"`
	URL     string              `json:"url"`
	Headers map[string][]string `json:"headers"`
	Payload string              `json:"payload"`
}

type RequestResult struct {
	ID uint64 `json:"id"`
}

func (cmd *RequestCommand) Execute() (interface{}, error) {
	reqURL, e := url.Parse(cmd.URL)
	if e != nil {
		return nil, e
	}

	id, port := counter.Next(), make(Port)
	go func() {
		defer close(port)
		request := &http.Request{
			Method: strings.ToUpper(cmd.Method),
			URL:    reqURL,
			Header: http.Header(cmd.Headers),
			Body:   ioutil.NopCloser(strings.NewReader(cmd.Payload)),
		}

		response, e := client.Do(request)
		port <- &PortData{response, e}
		// TODO: perform request and put response into port
	}()

	registry.Set(id, port)
	return &RequestResult{id}, nil
}
