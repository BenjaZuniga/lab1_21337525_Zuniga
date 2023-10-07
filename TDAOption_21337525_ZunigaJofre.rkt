#lang racket
(provide (all-defined-out))

#|..........................TDA Option..........................|#



#|..........................Constructor..........................|#


#|..........................Pertenencia..........................|#
;Nombre de la función: option?
;Dominio: lista
;Recorrido: boolean
;Tipo de recursion: Ninguna
;Descripción de la función: Verifica si una lista es una option
(define(option? op)
  (and (integer? (select-option-code op)) (string? (select-option-message op))
       (integer? (select-option-ChatbotCodeLink op)) (integer? (select-option-InicialFlowCodeLink op))
       (or (map string?(select-option-Keyword op))(null?(select-option-Keyword op)))))

#|..........................Selectores..........................|#
;Nombre de la función: select-option-code
;Dominio: option
;Recorrido: code
;Tipo de recursion: ninguna
;Descripción de la función: selecciona el code de una option
(define(select-option-code op)(car op))

;Nombre de la función: select-option-message
;Dominio: option
;Recorrido: message
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el message de una option
(define(select-option-message op)(cadr op))

;Nombre de la función: select-option-ChatbotCodeLink
;Dominio: option
;Recorrido: ChatbotCodeLink
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el ChatbotCodeLink de una option
(define(select-option-ChatbotCodeLink op)(caddr op))

;Nombre de la función:select-option-InicialFlowCodeLink
;Dominio: option
;Recorrido: InicialFlowCodeLink
;Tipo de recursion: Ninguna
;Descripción de la función:Selecciona el InicialFlowCodeLink de una option
(define(select-option-InicialFlowCodeLink op)(cadddr op))

;Nombre de la función: select-option-Keyword
;Dominio: option
;Recorrido: Keyword
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el Keyword de una option
(define(select-option-Keyword op)(list-ref op 4))

