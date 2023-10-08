#lang racket
(provide(all-defined-out))
#|..........................Especificación TDA User..........................|#
;user = user-register X user-login
;user-register= null | string X user-register
;user-login = string X null
#|..........................Constructor..........................|#
;Nombre de la función: user
;Dominio: 
;Recorrido: user
;Tipo de recursion: Ninguna
;Descripción de la función: Crea un TDA User
(define user (list (list)(list)))

#|..........................Selectores..........................|#
;Nombre de la función: select-user-register
;Dominio: user
;Recorrido: list
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona la lista dentro del TDA User que contiene los usuarios registrados en el sistema
(define(select-user-register user )(car user))

;Nombre de la función: select-user-login
;Dominio: user
;Recorrido: list
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona la lista dentro del TDA User que contiene el usuario logeado en el sistema
(define(select-user-login user)(cadr user))

;Nombre de la función: get-user-login
;Dominio: user
;Recorrido: string
;Tipo de recursion: Ninguna
;Descripción de la función: Devuelve el string del usuario logeado en el sistema
(define(get-user-login user)
  (if(not(empty? (select-user-login user)))
     (caadr user)
     "-"))
