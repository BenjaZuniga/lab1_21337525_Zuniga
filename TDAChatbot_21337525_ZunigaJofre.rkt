#lang racket
(require "TDAOption_21337525_ZunigaJofre.rkt")
(require "TDAFlow_21337525_ZunigaJofre.rkt")
(provide (all-defined-out))

#|..........................Constructor..........................|#
;Nombre de la función: chatbot
;Dominio: chatbotID (int) X name (String) X welcomeMessage (String) X startFlowId(int) X  flows
;Recorrido: chatbot
;Tipo de recursion: Natural de la funcion new-flow
;Descripción de la función: Crea un chatbot
(define (chatbot id name welcomeMessage startFlowId . flows)
  (list id name welcomeMessage startFlowId (if(not(null? flows))
                                           (remove (list)(new-flows flows))
                                           flows)))
#|..........................Pertenencia..........................|#
;Nombre de la función: chatbot?
;Dominio: list
;Recorrido: boolean
;Tipo de recursion: Ninguna
;Descripción de la función: Verifica si una lista es un chatbot
(define(chatbot? chatbot)
  (and(integer? (select-chatbot-id chatbot)) (string? (select-chatbot-name chatbot))
      (string? (select-chatbot-wM chatbot)) (integer?(select-chatbot-sFId chatbot))
      (or(empty?(select-chatbot-flow chatbot)) (map flow?(select-chatbot-flow chatbot)))))

#|..........................Modificadores..........................|#
;Nombre de la función: chatbot-add-flow
;Dominio: chatbot X flow
;Recorrido: chatbot
;Tipo de recursion: Natural, de la función add-flow
;Descripción de la función: Se ingresa un chatbot y un flow, y se reconstruye el flows de un chatbot con el flow ingresado,
; en caso de que el id del flow esté en flows, flows queda igual, sino se agrega flow a flows y se retorna el chatbot con un
;un flows nuevo
(define (chatbot-add-flow chatbot flow)
  (list(select-chatbot-id chatbot)(select-chatbot-name chatbot)
       (select-chatbot-wM chatbot)(select-chatbot-sFId chatbot)
       (add-flow (select-chatbot-flow chatbot)flow)))



#|..........................Selectores..........................|#
;Nombre de la función: select-chatbot-id
;Dominio: chatbot
;Recorrido: id
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el id de un chatbot
(define(select-chatbot-id chatbot)(car chatbot))

;Nombre de la función: select-chatbot-name
;Dominio: chatbot
;Recorrido: name
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el name de un chatbot
(define (select-chatbot-name chatbot)(cadr chatbot))

;Nombre de la función: select-chatbot-wM
;Dominio: chatbot
;Recorrido: welcomeMessage
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el welcomeMessage de un chatbot
(define(select-chatbot-wM chatbot)(caddr chatbot))

;Nombre de la función: select-chatbot-sFId
;Dominio: chatbot
;Recorrido: startFlowId
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el startFlowId de un chatbot
(define(select-chatbot-sFId chatbot)(cadddr chatbot))

;Nombre de la función: select-chatbot-flow
;Dominio: chatbot
;Recorrido: flows
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el flows de un chatbot
(define(select-chatbot-flow chatbot)(list-ref chatbot 4))

#|..........................Otros..........................|#
;Nombre de la función: new-flows
;Dominio: flows
;Recorrido: flows
;Tipo de recursion: Natural
;Descripción de la función: Reconstruye un flows en caso de que los ids de los flow que lo componen esten repetidos,
;dejando un flow por id, en cas que no hayan ids repetidos devuelve el flows como estaba
(define new-flows(lambda(flows)
  (define create-flow(lambda(flows ids)
    (if(not (null? (cdr flows)))
       (if (list?(member (select-flow-id (car flows)) ids))
        (cons(car flows)(create-flow(cdr flows)(remove (select-flow-id (car flows)) ids)))
        (create-flow(cdr flows) ids ))
       (if (list?(member (select-flow-id (car flows)) ids))
        (cons(car flows) null)
        (cons null null )))))
                    (create-flow flows (get-flow-ids flows))))

;Nombre de la función: add-flow
;Dominio: flows X flow
;Recorrido: flows
;Tipo de recursion: Natural
;Descripción de la función: Se ingresa un flows de un chatbot y un flow, si el id del flow ya está en un flow del
;flows se devuelve flows, sino se agrega el flow a flows, mediante recuersion natural
(define(add-flow chatbot-flow flow)
  (if(boolean?(member (select-flow-id flow)(get-flow-ids chatbot-flow)))
     (if(null? chatbot-flow)
        (cons flow null)
        (cons(car chatbot-flow)(add-flow (cdr chatbot-flow) flow)))
     chatbot-flow))


;Nombre de la función: get-flow-ids
;Dominio: flows
;Recorrido: list
;Tipo de recursion: Ninguna
;Descripción de la función: Se ingresa un flows de un chatbot y devuelve una lista con los ids de los flow que componen el flow
(define (get-flow-ids flows)
  (if(not(null? flows))
     (remove-duplicates (map select-flow-id flows))
     (list)))
