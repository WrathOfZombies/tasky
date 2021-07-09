package main

import "fmt"

func main() {
	sum := add(1, 2)
	fmt.Println("This is the tasky bot...")
	fmt.Println("I just added 1 & 2. It is ",sum);
}

func add(x, y int) int {
	return x+y;
}

