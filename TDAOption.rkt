#lang racket
(provide (all-defined-out))

#|TDA Option|#



#|..........................Constructor..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (option code message ChatbotCodeLink FlowCodeLink . Keyword)
  (if(option?(list code message ChatbotCodeLink FlowCodeLink Keyword))
     (list code message ChatbotCodeLink FlowCodeLink Keyword)
     "Los parametros ingresados no corresponden " ))

#|..........................Pertenencia..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(option? op) (if(integer? (select-code op))
                       (if(string? (select-message op))
                          (if(integer? (select-ChatbotCodeLink op))
                             (if(integer? (select-FlowCodeLink op))
                                (if(or (map string?(select-Keyword op))
                                       (map null?(select-Keyword op)))
                                        #t #f)#f)#f)#f)#f)) 
#|..........................Selectores..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-code op)(car op))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-message op)(cadr op))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-ChatbotCodeLink op)(caddr op))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-FlowCodeLink op)(cadddr op))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-Keyword op)(list-ref op 4))

#|..........................Modificadores..........................|#
