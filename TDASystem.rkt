#lang racket
(require "TDAOption.rkt")
(require "TDAFlow.rkt")
(require "TDAChatbot.rkt")

#|Constructor|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (system name . chatbot)
  (list (list ) (list ) name chatbot))

#|Pertenencia|#

#|Selector|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (select-chathistory sys)(car sys))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (select-user sys)(cadr sys))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (select-system-name sys)(caddr sys))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-chatbot sys)(cadddr sys))
#|Modificador|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(system-add-chatbot sys cb)(append(select-chatbot sys)(list cb)))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (system-add-user sys user)(append(select-user sys)(list user)))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(system-login sys user)
  (if(map (equal? user (select-user sys)))
     (if(map (equal? 1 (select-user sys)))
        (list (list) (append 1 (select-user sys))
              (select-system-name sys) (select-chatbot sys))
        "Hay un usuario activo")
     "Usuario no registrado"))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (system-logout sys)
  (list (select-chathistory sys)(remove 1 (select-user sys))
        (select-system-name sys)(select-chatbot sys)))

#|Otros|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (chatbot-uniques-id sys)
  (check-duplicates(append(list )
                          (map select-chatbot-id(select-chatbot sys)))
                   #:default #t))
