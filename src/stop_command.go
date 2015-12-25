package main

type StopCommand struct{}

func (cmd *StopCommand) Execute() (interface{}, error) {
	registry.Close()
	return nil, nil
}
