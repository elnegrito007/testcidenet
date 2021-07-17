package main

import (
	"context"
	"fmt"
	"github.com/go-chi/chi"
	"github.com/go-chi/cors"
	"github.com/go-redis/redis"
	"net/http"
	"os"
	"regexp"
	"strconv"
	"time"
)

func ExprecionCorreo() string {
	var correo = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
	return correo
}

func ExprecionTexto() string {
	var texto = `[A-Z]`
	return texto
}

func ExprecionAlfaNumecioTodos() string {
	var texto = `[a-zA-Z0-9]`
	return texto
}

var RegNum, RegTex, RegCor = regexp.MustCompile(ExprecionAlfaNumecioTodos()), regexp.MustCompile(ExprecionTexto()), regexp.MustCompile(ExprecionCorreo())

func PortHost() string {
	port := os.Getenv("PORT")
	if port == "" {
		port = "3000"
	}
	return port
}

func PassRedis() string {
	pass := os.Getenv("PASSREDIS")
	if pass == "" {
		pass = "fDDMk1f5hN0cQe6Buv9xKliziGgnDssv"
	}
	return pass
}

func HostRedis() string {
	hostRedis := os.Getenv("HOSTREDIS")
	if hostRedis == "" {
		hostRedis = "redis-16446.c228.us-central1-1.gce.cloud.redislabs.com:16446"
	}
	return hostRedis
}

func DbConect() (cliente *redis.Client) {
	client := redis.NewClient(&redis.Options{
		Addr:     HostRedis(),
		Password: PassRedis(),
		DB:       0,
	})
	return client
}

var Connect = DbConect()
var Ctx = context.Background()

func DeleteEmployee(w http.ResponseWriter, r *http.Request) {
	dni := r.FormValue("dni")
	if dni == "" || RegNum.MatchString(dni) == false {
		w.WriteHeader(400)
		_, _ = w.Write([]byte(`{"e":1,"d":[1]}`))
	} else {
		registrys, _ := Connect.Keys("Employee_" + dni + "*").Result()
		if len(registrys) > 0 {
			_ = Connect.Del(registrys[0])
			_, _ = w.Write([]byte(`{"e":0,"d":[200]}`))
		} else {
			w.WriteHeader(400)
			_, _ = w.Write([]byte(`{"e":1,"d":[3]}`))
		}
	}
}

func CreateEmployee(w http.ResponseWriter, r *http.Request) {
	firstSurname, secondSurname, firstName, otherName, country, typeDni, dni, dateInit, area := r.FormValue("firstSurname"), r.FormValue("secondSurname"), r.FormValue("firstName"), r.FormValue("otherName"), r.FormValue("country"), r.FormValue("typeDni"), r.FormValue("dni"), r.FormValue("dateInit"), r.FormValue("area")
	if firstSurname == "" || secondSurname == "" || firstName == "" || country == "" || typeDni == "" || dni == "" || dateInit == "" || area == "" || RegTex.MatchString(firstSurname) == false || RegTex.MatchString(secondSurname) == false || RegTex.MatchString(firstName) == false || RegNum.MatchString(country) == false || RegNum.MatchString(typeDni) == false || RegNum.MatchString(area) == false || RegNum.MatchString(dni) == false {
		w.WriteHeader(400)
		_, _ = w.Write([]byte(`{"e":1,"d":[1]}`))
	} else {
		if otherName != "" && RegTex.MatchString(otherName) == false && len(otherName) > 50 {
			w.WriteHeader(400)
			_, _ = w.Write([]byte(`{"e":1,"d":[3]}`))
		} else {
			if len(firstSurname) > 20 || len(secondSurname) > 20 || len(firstName) > 20 {
				w.WriteHeader(400)
				_, _ = w.Write([]byte(`{"e":1,"d":[2]}`))
			} else {
				registrys, _ := Connect.Keys("Employee_*_" + firstName + "_" + firstSurname + "_*").Result()
				t := time.Now().Unix()
				_ = Connect.Set("Employee_"+dni+"_"+firstName+"_"+firstSurname+"_"+strconv.FormatInt(t, 10), `{"firstSurname":"`+firstSurname+`","secondSurname":"`+secondSurname+`","firstName":"`+firstName+`","otherName":"`+otherName+`","country":"`+country+`","typeDni":"`+typeDni+`","dni":"`+dni+`","country":"`+country+`","area":"`+area+`","date":"`+strconv.FormatInt(t, 10)+`"}`, 0).Err()
				_, _ = w.Write([]byte(`{"e":0,"d":[200,` + strconv.Itoa(len(registrys)) + `]}`))
			}
		}
	}
}

func EditEmployee(w http.ResponseWriter, r *http.Request) {
	firstSurname, secondSurname, firstName, otherName, country, typeDni, dni, dateInit, area, date := r.FormValue("firstSurname"), r.FormValue("secondSurname"), r.FormValue("firstName"), r.FormValue("otherName"), r.FormValue("country"), r.FormValue("typeDni"), r.FormValue("dni"), r.FormValue("dateInit"), r.FormValue("area"), r.FormValue("date")
	if date == "" || firstSurname == "" || secondSurname == "" || firstName == "" || country == "" || typeDni == "" || dni == "" || dateInit == "" || area == "" || RegTex.MatchString(firstSurname) == false || RegTex.MatchString(secondSurname) == false || RegTex.MatchString(firstName) == false || RegNum.MatchString(country) == false || RegNum.MatchString(typeDni) == false || RegNum.MatchString(area) == false || RegNum.MatchString(dni) == false {
		w.WriteHeader(400)
		_, _ = w.Write([]byte(`{"e":1,"d":[1]}`))
	} else {
		if otherName != "" && RegTex.MatchString(otherName) == false && len(otherName) > 50 {
			w.WriteHeader(400)
			_, _ = w.Write([]byte(`{"e":1,"d":[3]}`))
		} else {
			if len(firstSurname) > 20 || len(secondSurname) > 20 || len(firstName) > 20 {
				w.WriteHeader(400)
				_, _ = w.Write([]byte(`{"e":1,"d":[2]}`))
			} else {
				t := time.Now().Unix()
				registrys, _ := Connect.Keys("Employee_*_" + date).Result()
				if len(registrys) > 0 {
					_ = Connect.Del(registrys[0])
					registrys2, _ := Connect.Keys("Employee_*_" + firstName + "_" + firstSurname + "_*").Result()
					_ = Connect.Set("Employee_"+dni+"_"+firstName+"_"+firstSurname+"_"+date, `{"firstSurname":"`+firstSurname+`","secondSurname":"`+secondSurname+`","firstName":"`+firstName+`","otherName":"`+otherName+`","country":"`+country+`","typeDni":"`+typeDni+`","dni":"`+dni+`","country":"`+country+`","area":"`+area+`","date":"`+date+`","edit":"`+strconv.FormatInt(t, 10)+`"}`, 0).Err()
					_, _ = w.Write([]byte(`{"e":0,"d":[200,` + strconv.Itoa(len(registrys2)) + `]}`))
				} else {
					w.WriteHeader(400)
					_, _ = w.Write([]byte(`{"e":1,"d":[4]}`))
				}
			}
		}
	}
}

func ListEmployee(w http.ResponseWriter, r *http.Request) {
	registrys, _ := Connect.Keys("Employee_*").Result()
	if len(registrys) > 0 {
		info, _ := Connect.MGet(registrys...).Result()
		_, _ = fmt.Fprint(w, info)
	} else {
		w.WriteHeader(400)
		_, _ = w.Write([]byte(`{"e":1,"d":[3]}`))
	}
}

func ViewEmployee(w http.ResponseWriter, r *http.Request) {
	date := r.FormValue("date")
	if date == "" || RegNum.MatchString(date) == false {
		w.WriteHeader(400)
		_, _ = w.Write([]byte(`{"e":1,"d":[1]}`))
	} else {
		registrys, _ := Connect.Keys("Employee_*_" + date).Result()
		if len(registrys) > 0 {
			info, _ := Connect.Get(registrys[0]).Result()
			_, _ = fmt.Fprint(w, info)
		} else {
			w.WriteHeader(400)
			_, _ = w.Write([]byte(`{"e":1,"d":[3]}`))
		}
	}
}

func Status(w http.ResponseWriter, r *http.Request) {
	_, _ = w.Write([]byte(`{"e":0,"d":[200]}`))
}

func Router() http.Handler {
	r := chi.NewRouter()
	cors_ := cors.New(cors.Options{
		AllowedOrigins:   []string{"*"},
		AllowedMethods:   []string{"GET", "POST", "OPTIONS"},
		AllowedHeaders:   []string{"Accept", "Authorization", "Content-Type"},
		ExposedHeaders:   []string{"Link"},
		AllowCredentials: true,
		MaxAge:           300,
	})
	r.Use(cors_.Handler)
	r.Group(func(r chi.Router) {
		r.Post("/v1/createEmployee", CreateEmployee)
		r.Post("/v1/editEmployee", EditEmployee)
		r.Post("/v1/viewEmployee", ViewEmployee)
		r.Get("/v1/listEmployee", ListEmployee)
		r.Post("/v1/deleteEmployee", DeleteEmployee)
		r.Get("/v1/status", Status)
	})
	return r
}

func main() {
	err := http.ListenAndServe(":"+PortHost(), Router())
	if err != nil {
		return
	}
}
