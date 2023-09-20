#lang racket
(require "TDAOption.rkt")
(require "TDAFlow.rkt")
(provide (all-defined-out))

#|Constructor|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (chatbot id name welcomeMessage . flows)
  (if(chatbot? (list id name welcomeMessage flows))
     (if(integer? (flow-uniques-id(list id name welcomeMessage flows)))
                  "IDs de flow repetidos"
                  (list id name welcomeMessage flows))#f))
#|Pertenencia|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(chatbot? chatbot)
  (if(integer? (select-chatbot-id chatbot))
     (if(string? (select-chatbot-name chatbot))
        (if(string? (select-chatbot-wM chatbot))
           (if(or(empty?(select-chatbot-flow chatbot))
                 (map flow?(select-chatbot-flow chatbot))
                 )#t #f)#f)#f)#f))

#|Modificadores|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (chatbot-add-flow cb flow)
  (define (aux cb flow new-chatbot)
               (if(list? cb)
                  (if(integer?
                      (flow-uniques-id(list
                                       (select-chatbot-id new-chatbot)
                                       (select-chatbot-name new-chatbot)
                                       (select-chatbot-wM new-chatbot)
                                       (append(select-chatbot-flow new-chatbot)
                                              (list flow)))))
                     "Ids de flow repetidos"
                     (list (select-chatbot-id new-chatbot)(select-chatbot-name new-chatbot)
                           (select-chatbot-wM new-chatbot)
                           (append(select-chatbot-flow new-chatbot)(list flow))))
                  (aux(cdr cb) flow new-chatbot)))
  (aux cb flow cb))

#|Selectores|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-chatbot-id chatbot)(car chatbot))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (select-chatbot-name chatbot)(cadr chatbot))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-chatbot-wM chatbot)(caddr chatbot))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-chatbot-flow chatbot)(cadddr chatbot))

#|Otros|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (flow-uniques-id chatbot)
  (check-duplicates(append(list )
                          (map select-id(select-chatbot-flow chatbot)))
                   #:default #t))
