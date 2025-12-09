package main

import (
	"context"
	"fmt"
	"log"

	"github.com/redis/go-redis/v9"
)

func main() {
	ctx := context.Background()

	rdb := redis.NewClient(&redis.Options{
		Addr:     "localhost:6379",
		Password: "",
		DB:       0,
	})

	// ping
	pong, err := rdb.Ping(ctx).Result()
	if err != nil {
		log.Fatalf("Redis connection failed: %v", err)
	}
	fmt.Println("Connected to Redis:", pong)

	// set
	err = rdb.Set(ctx, "message", "Hello, Redis!", 0).Err()
	if err != nil {
		log.Fatalf("SET failed: %v", err)
	}
	fmt.Println("SET: message = 'Hello, Redis!'")

	// get
	val, err := rdb.Get(ctx, "message").Result()
	if err != nil {
		log.Fatalf("GET failed: %v", err)
	}
	fmt.Println("GET: message =", val)

	// del
	err = rdb.Del(ctx, "message").Err()
	if err != nil {
		log.Fatalf("DEL failed: %v", err)
	}
	fmt.Println("DEL: message key deleted")

	// get
	_, err = rdb.Get(ctx, "message").Result()
	if err == redis.Nil {
		fmt.Println("Key 'message' does not exist (as expected)")
	} else if err != nil {
		log.Fatalf("GET failed: %v", err)
	}
}
