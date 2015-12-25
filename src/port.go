package main

import "net/http"

type PortData struct {
	Response *http.Response
	Error    error
}

type Port chan *PortData
