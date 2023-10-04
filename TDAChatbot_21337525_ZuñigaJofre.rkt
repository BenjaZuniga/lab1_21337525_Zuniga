#lang racket
(require "TDAOption_21337525_ZuñigaJofre.rkt")
(require "TDAFlow_21337525_ZuñigaJofre.rkt")
(provide (all-defined-out))

#|..........................Constructor..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (chatbot id name welcomeMessage startFlowId . flows)
  (list id name welcomeMessage startFlowId (if(not(null? flows))
                                           (remove (list)(new-flow flows))
                                           flows)))
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
           (if(integer?(select-chatbot-sFId chatbot))
              (if(or(empty?(select-chatbot-flow chatbot))
                    (map flow?(select-chatbot-flow chatbot))
                 )#t #f)#f)#f)#f)#f))

#|..........................Modificadores..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (chatbot-add-flow chatbot flow)
  (list(select-chatbot-id chatbot)(select-chatbot-name chatbot)
       (select-chatbot-wM chatbot)(select-chatbot-sFId chatbot)
       (add-flow (select-chatbot-flow chatbot)flow)))

(define(add-flow chatbot-flow flow)
  (if(boolean?(member (select-flow-id flow)(get-flow-ids chatbot-flow)))
     (if(null? chatbot-flow)
        (cons flow null)
        (cons(car chatbot-flow)(add-flow (cdr chatbot-flow) flow)))
     chatbot-flow))

#|..........................Selectores..........................|#
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
(define(select-chatbot-sFId chatbot)(cadddr chatbot))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-chatbot-flow chatbot)(list-ref chatbot 4))

#|..........................Otros..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define new-flow(lambda(flow)
  (define create-flow(lambda(flow ids)
    (if(not (null? (cdr flow)))
       (if (list?(member (select-flow-id (car flow)) ids))
        (cons(car flow)(create-flow(cdr flow)(remove (select-flow-id (car flow)) ids)))
        (create-flow(cdr flow) ids ))
       (if (list?(member (select-flow-id (car flow)) ids))
        (cons(car flow) null)
        (cons null null )))))
                    (create-flow flow (get-flow-ids flow))))


;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (get-flow-ids flow)
  (if(not(null? flow))
     (remove-duplicates (map select-flow-id flow))
     (list)))
