package main

import "sync/atomic"

type Counter uint64

func (counter *Counter) Next() uint64 {
	i := (*uint64)(counter)
	return atomic.AddUint64(i, 1)
}
