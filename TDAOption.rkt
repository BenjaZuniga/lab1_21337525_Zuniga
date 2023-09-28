#lang racket
(provide (all-defined-out))

#|..........................TDA Option..........................|#



#|..........................Constructor..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (option code message ChatbotCodeLink InicialFlowCodeLink . Keyword)
  (if(option?(list code message ChatbotCodeLink InicialFlowCodeLink Keyword))
     (list code message ChatbotCodeLink InicialFlowCodeLink Keyword)
     "Los parametros ingresados no corresponden " ))

#|..........................Pertenencia..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(option? op) (if(integer? (select-option-code op))
                       (if(string? (select-option-message op))
                          (if(integer? (select-option-ChatbotCodeLink op))
                             (if(integer? (select-option-InicialFlowCodeLink op))
                                (if(or (map string?(select-option-Keyword op))
                                       (null?(select-option-Keyword op)))
                                        #t #f)#f)#f)#f)#f)) 
#|..........................Selectores..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-option-code op)(car op))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-option-message op)(cadr op))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-option-ChatbotCodeLink op)(caddr op))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-option-InicialFlowCodeLink op)(cadddr op))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-option-Keyword op)(list-ref op 4))

#|..........................Modificadores..........................|#

#|..........................Otros..........................|#
