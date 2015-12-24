package main

import "fmt"

type PortAction int

const (
	PortGet = iota * 1000
	PortSet
)

type PortCommand struct {
	Action PortAction
	ID     uint64
	Port   Port
	Result chan Port
	Error  chan error
}

type PortRegistry struct {
	registry map[uint64]Port
	commands chan *PortCommand
}

func NewPortRegistry(queueSize int) *PortRegistry {
	return &PortRegistry{
		registry: map[uint64]Port{},
		commands: make(chan *PortCommand, queueSize),
	}
}

func (reg *PortRegistry) Close() {
	close(reg.commands)
}

func (reg *PortRegistry) Start() {
	go func() {
		for cmd := range reg.commands {
			switch cmd.Action {
			case PortGet:
				result, ok := reg.registry[cmd.ID]
				if !ok {
					cmd.Error <- ErrInternal("invalid id: " + fmt.Sprint(cmd.ID))

				} else {
					delete(reg.registry, cmd.ID)
					cmd.Result <- result
				}

			case PortSet:
				reg.registry[cmd.ID] = cmd.Port

			default:
				panic("fatal: registry received invalid command.")
			}
		}
	}()
}

func (reg *PortRegistry) Set(id uint64, port Port) {
	reg.commands <- &PortCommand{PortSet, id, port, nil, nil}
}

func (reg *PortRegistry) Delete(id uint64) (Port, error) {
	result, err := make(chan Port), make(chan error)
	defer close(result)
	defer close(err)

	reg.commands <- &PortCommand{PortGet, id, nil, result, err}
	select {
	case e := <-err:
		return nil, e
	case r := <-result:
		return r, nil
	}
}
