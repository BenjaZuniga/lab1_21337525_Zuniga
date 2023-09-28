#lang racket
(require "TDAOption.rkt")
(require "TDAFlow.rkt")
(require "TDAChatbot.rkt")
(require "TDAUser.rkt")
(require "TDAChathistory.rkt")
(provide(all-defined-out))
#|..........................TDASystem..........................|#

#|..........................Constructor..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (system name InicialChatbotCodeLink . chatbot)
  (list InicialChatbotCodeLink user (list) name InicialChatbotCodeLink
        (get-flow-id chatbot InicialChatbotCodeLink)
        (if(not(null? chatbot))
           (remove (list)(new-chatbot chatbot))
            chatbot)))

#|..........................Pertenencia..........................|#

#|Selector|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (select-default-chatbot-id sys)(car sys))

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
(define (select-system-chathistory sys)(caddr sys))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-system-name sys)(cadddr sys))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-system-inicialCbCL sys)(list-ref sys 4))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-system-inicialFlow sys)(list-ref sys 5))


(define(select-system-chatbot sys)(list-ref sys 6))

#|..........................Modificador..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(system-add-chatbot system chatbot)
 (if(boolean?(member (select-chatbot-id chatbot)
                     (get-chatbot-ids (select-system-chatbot system))))
    (list (select-default-chatbot-id system)(select-user system)
          (select-system-chathistory system)
          (select-system-name system)(select-system-inicialCbCL system)
          (select-system-inicialFlow system)
          (append (select-system-chatbot system)(list chatbot)))
    system))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (system-add-user system user)
  (if(boolean? (member user (select-user-register(select-user system))))
     (list (select-default-chatbot-id system)
        (list(append(select-user-register(select-user system))
                    (list user ))
             (select-user-login(select-user system)))
        (select-system-chathistory system)
        (select-system-name system)(select-system-inicialCbCL system)
        (select-system-inicialFlow system)
        (select-system-chatbot system))
     system))
    

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(system-login sys user)
  (if(and(empty? (select-user-login(select-user sys)))
         (not(boolean? (member user (select-user-register(select-user sys))))))
     (list (select-default-chatbot-id sys) 
           (list (select-user-register(select-user sys))
                 (append (select-user-login(select-user sys))
                         (list user)))
           (select-system-chathistory sys)
           (select-system-name sys) (select-system-inicialCbCL sys)
           (select-system-inicialFlow sys)(select-system-chatbot sys))
        sys))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (system-logout sys)
  (list (select-default-chatbot-id sys)
        (list (select-user-register(select-user sys))
              (list))
        (select-system-chathistory sys)
        (select-system-name sys)(select-default-chatbot-id sys)
        (select-system-inicialFlow sys)(select-system-chatbot sys)))

#|..........................Otros..........................|#
(define (system-talk-rec system message)
  (if(not(empty? (select-user-login(select-user system))))
     (search system (select-system-chatbot system)
                  (select-system-inicialCbCL system)
                  (select-system-inicialFlow system ) message  
                  (select-system-chathistory system))
     system))

(define(search system tda id1 id2 message history)
    (cond
          [(null? tda) history]
          [(option? (car tda))
           (if(or(string-contains? ( select-option-message (car tda)) message)
                 (list?(member message (select-option-Keyword (car tda))))
                 (empty?(select-system-chathistory system)))
              (list (append history (map select-option-message tda))(select-user system)
                   (select-system-name system)(select-option-ChatbotCodeLink (car tda))
                   (select-option-InicialFlowCodeLink (car tda))(select-system-chatbot system))
              (search system (cdr tda) id1 id2 message history))]
          [(and(equal? id1 (caar tda))(chatbot? (car tda)))
           (search system (select-chatbot-flow (car tda)) 90503
                   id2 message
                   (append history
                           (list (string-append(~a(current-seconds)) "-"(cadar(select-user system))": "message "\n")
                                 (~a(current-seconds))"-"(select-chatbot-name (car tda))": ")))]
          [(and(not(equal? id1 (caar tda)))(chatbot? (car tda)))
               (search system (cdr tda)id1 id2 message history)]
          [(and(equal? id2 (caar tda))(flow?(car tda)))
               (search system (select-flow-Option (car tda))id1
                       99999 message
                       (append history (list(select-flow-name(car tda)))))]
          [(not(equal? id2 (caar tda)))
               (search system (cdr tda)id1 id2 message history)]))
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define new-chatbot(lambda(chatbot)
  (define create-chatbot(lambda(chatbot ids)
    (if(not (null? (cdr chatbot)))
       (if (list?(member (select-chatbot-id (car chatbot)) ids))
        (cons(car chatbot)(create-chatbot(cdr chatbot)(remove (select-chatbot-id (car chatbot)) ids)))
        (create-chatbot(cdr chatbot) ids ))
       (if (list?(member (select-chatbot-id (car chatbot)) ids))
        (cons(car chatbot) null)
        (cons null null )))))
                    (create-chatbot chatbot (get-chatbot-ids chatbot))))


;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (get-chatbot-ids chatbot)
  (if(not(null? chatbot))
     (remove-duplicates (map select-chatbot-id chatbot))
     (list)))

(define (get-flow-id chatbot id)
  (cond
          [(equal? id (caar chatbot))
           (select-chatbot-sFId (car chatbot))]
          [(not(equal? id (caar chatbot)))
               (get-flow-id (cdr chatbot)id)]))
