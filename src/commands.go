package main

var counter Counter
var registry *PortRegistry

type Command interface {
	Execute() (interface{}, error)
}

// 1. start
// 2. request
// 3. response
// 4. stop

type StartCommand struct{}

func (cmd *StartCommand) Execute() (interface{}, error) {
	counter = Counter(0)
	registry = NewPortRegistry(8)
	registry.Start()
	return nil, nil
}

type RequestCommand struct {
	Method  string            `json:"method"`
	Url     string            `json:"url"`
	Headers map[string]string `json:"headers"`
	Payload string            `json:"payload"`
}

type RequestResult struct {
	ID uint64 `json:"id"`
}

func (cmd *RequestCommand) Execute() (interface{}, error) {
	id, port := counter.Next(), make(Port)
	go func() {
		defer close(port)

		// TODO: perform request and put response into port
	}()

	registry.Set(id, port)
	return &RequestResult{id}, nil
}

type ResponseCommand struct {
	ID uint64 `json:"id"`
}

type ResponseResult struct {
	StatusCode int               `json:"status_code"`
	Headers    map[string]string `json:"headers"`
	Payload    string            `json:"payload"`
}

func (cmd *ResponseCommand) Execute() (interface{}, error) {
	port, e := registry.Delete(cmd.ID)
	if e != nil {
		return nil, e
	}

	// TODO: Obtain http.Response from port and build a result payload.
	return &ResponseResult{}, nil
}

type StopCommand struct{}

func (cmd *StopCommand) Execute() (interface{}, error) {
	registry.Close()
	return nil, nil
}
