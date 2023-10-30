package main

import (
	"net/http"
	"github.com/labstack/echo/v4"
)

func getIsAlive(c echo.Context) error {
	return c.String(http.StatusOK, "Ok")
}

func main() {
	e := echo.New()
	e.GET("/", getIsAlive)
	e.GET("/isAlive", getIsAlive)
	e.Logger.Fatal(e.Start(":8585"))
}
