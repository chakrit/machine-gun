package main

import "testing"

func TestCounter(t *testing.T) {
	counter := Counter(0)
	results := []chan uint64{
		make(chan uint64),
		make(chan uint64),
		make(chan uint64),
	}

	for _, result := range results {
		go func(output chan uint64) {
			defer close(output)

			sum := uint64(0)
			for i := 0; i < 100; i++ {
				sum += counter.Next()
			}

			output <- sum
		}(result)
	}

	sum := uint64(0)
	for _, result := range results {
		sum += <-result
	}

	if sum != 45150 { // (300*301)/2
		t.Errorf("should equals 45150: %d", sum)
	}
}
