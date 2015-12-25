package main

import (
	"net/http"
)

var client *http.Client
var counter Counter
var registry *PortRegistry

// required, not used.
func main() { /*no-op*/ }
