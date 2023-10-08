#lang racket
(require "TDAOption_21337525_ZunigaJofre.rkt")
(provide (all-defined-out))
#|..........................Especificación TDA Flow..........................|#
;flow = id X name-msg X Option
;id = int
;name-msg = string
;Option = null | option X Option


#|..........................Constructor..........................|#
;Nombre de la función: flow
;Dominio: id (int) X name-msg (String)  X Option*
;Recorrido: flow
;Tipo de recursion: Natural de la funcion new-Option
;Descripción de la función: Crea un TDA Flow y verifica que en Option no hayan opciones repetidas en base a sus ids
(define (flow id name-msg . Option)
  (list id name-msg (if(not(null? Option))
                   (remove (list)(new-Option Option))
                   Option)))


#|..........................Pertenecia..........................|#
;Nombre de la función: flow?
;Dominio: list
;Recorrido: boolean
;Tipo de recursion: Ninguna
;Descripción de la función: Verifica si una lista es un flow
(define (flow? flow)
  (and (integer? (select-flow-id flow)) (string? (select-flow-name flow))
       (or (map option?(select-flow-Option flow)) (null? (select-flow-Option flow)))))

#|..........................Selectores..........................|#
;Nombre de la función: select-flow-id
;Dominio: flow
;Recorrido: id
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el id de un flow
(define(select-flow-id flow)(car flow))

;Nombre de la función: select-flow-name
;Dominio: flow
;Recorrido: name-msg
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el name de un flow
(define (select-flow-name flow)(cadr flow))

;Nombre de la función: select-flow-Option
;Dominio: flow
;Recorrido: Option
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el option de un flow
(define (select-flow-Option flow)(caddr flow))

#|..........................Modificadores..........................|#
;Nombre de la función: flow-add-option
;Dominio: flow X option
;Recorrido: flow
;Tipo de recursion: Ninguna
;Descripción de la función: Se agrega una option a Option en un flow si es que el id de la opción que se intenta agregar
; no está repetido, sino se devuelve el flow como estaba
(define(flow-add-option flow option)
 (if(boolean?(member (select-option-code option)
                     (get-option-ids (select-flow-Option flow))))
    (list (select-flow-id flow)(select-flow-name flow)
          (append (select-flow-Option flow)(list option)))
    flow))

#|..........................Otros..........................|#
;Nombre de la función: new-Option
;Dominio: Option
;Recorrido: Option
;Tipo de recursion: Natural
;Descripción de la función: Ingresa un Option que con varias option y lo rehace sin ids repetidos en caso de que esten repetidos
(define new-Option(lambda(option)
  (define create-Option(lambda(option ids)
    (if(not (null? (cdr option)))
       (if (list?(member (select-option-code (car option)) ids))
        (cons(car option)(create-Option(cdr option)(remove (select-option-code (car option)) ids)))
        (create-Option(cdr option) ids ))
       (if (list?(member (select-option-code (car option)) ids))
        (cons(car option) null)
        (cons null null )))))
                    (create-Option option (get-option-ids option))))

;Nombre de la función: get-option-ids
;Dominio: Option
;Recorrido: list
;Tipo de recursion: Ninguna
;Descripción de la función: Se ingresa un Option de un flow y devuelve los code de las option que componen al Option sin codes
;duplicados en una lista
(define (get-option-ids Option)
  (if(not(null? Option))
     (remove-duplicates (map select-option-code Option))
     (list)))

;Nombre de la función: get-option-chatbots-ids
;Dominio: Option
;Recorrido: list
;Tipo de recursion: Ninguna
;Descripción de la función:  Se ingresa un Option de un flow y devuelve los ChatbotCodeLink de las option que componen al Option
;en una lista
(define (get-option-chatbots-ids Option)
  (if(not(null? Option))
     (map select-option-ChatbotCodeLink Option)
     (list)))

;Nombre de la función: get-option-flows-ids
;Dominio: Option
;Recorrido: list
;Tipo de recursion: Ninguna
;Descripción de la función: Se ingresa un Option de un flow y devuelve los InicialFlowCodeLink de las option que componen al Option
;en una lista
(define (get-option-flows-ids option)
  (if(not(null? option))
     (map select-option-InicialFlowCodeLink option)
     (list)))

;Nombre de la función: get-option-Keyword
;Dominio: Option
;Recorrido: list
;Tipo de recursion: Ninguna
;Descripción de la función: Se ingresa un Option de un flow y devuelve los Keyword de las option que componen al Option
;en una lista
(define (get-option-Keyword option)
  (if(not(null? option))
     (map select-option-Keyword option)
     (list)))
