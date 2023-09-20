#lang racket
(require "TDAOption.rkt")
(provide (all-defined-out))
#|TDA Flow|#

#|..........................Constructor..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (flow name . Option)
  (if(flow? (list name Option))
            (if(integer? (option-uniques-id (list name Option)))
               "IDs de opciones repetidos"
               (list name Option))
            "Los parametros ingresados no son validos"))

#|..........................Pertenecia..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (flow? flow)
  (if(string? (SelectName flow))
     (if(or (map option?(SelectOption flow))(map empty? (SelectOption flow)))
        #t #f)#f))
#|..........................Selectores..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(SelectId flow)(car flow))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (SelectName flow)(car flow))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (SelectOption flow)(cadr flow))

#|..........................Modificadores..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(flow-add-option fl option)
  (if(integer?
      (option-uniques-id(list (SelectName fl)
                              (append(SelectOption fl) (list option)))))
     "IDs de opciones repetidos"
     (list (SelectName fl) (append(SelectOption fl) (list option)))))

#|..........................Otros..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (option-uniques-id flow)
  (check-duplicates(append(list )
                          (map select-code(SelectOption flow)))
                   #:default #t))
