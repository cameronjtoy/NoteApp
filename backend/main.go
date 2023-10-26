package main

import (
	"net/http"
	"note-app/initializers"

	"github.com/gin-gonic/gin"
)

func init() {
	initializers.LoadEnvVar()
}

func main() {
	router := gin.Default()

	router.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "Hello, world!",
		})
	})

	router.Run()
}
