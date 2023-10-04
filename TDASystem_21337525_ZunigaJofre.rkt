#lang racket
(require "TDAOption_21337525_ZunigaJofre.rkt")
(require "TDAFlow_21337525_ZunigaJofre.rkt")
(require "TDAChatbot_21337525_ZunigaJofre.rkt")
(require "TDAUser_21337525_ZunigaJofre.rkt")
(require "TDAChathistory_21337525_ZunigaJofre.rkt")
(provide(all-defined-out))

#|..........................Constructor..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (system name InicialChatbotCodeLink . chatbot)
  (list InicialChatbotCodeLink user chathistory name
        (list) (list) (list)(if(not(null? chatbot))
                               (remove (list)(new-chatbot chatbot))
                                chatbot)))

#|..........................Pertenencia..........................|#

#|Selector|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (select-system-InicialChatbotCodeLink sys)(car sys))

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
(define(select-system-option-chatbots sys)(list-ref sys 4))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-system-option-flows sys)(list-ref sys 5))


;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-system-option-keywords sys)(list-ref sys 6))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-system-chatbot sys)(list-ref sys 7))

#|..........................Modificador..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(system-add-chatbot system chatbot)
 (if(boolean?(member (select-system-InicialChatbotCodeLink chatbot)
                     (get-chatbot-ids (select-system-chatbot system))))
    (list (select-system-InicialChatbotCodeLink chatbot)(select-user system)
          (select-system-chathistory system)
          (select-system-name system)(select-system-option-chatbots system)
          (select-system-option-flows system) (select-system-option-keywords system)
          (append (select-system-chatbot system)(list chatbot)))
    system))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (system-add-user system user)
  (if(boolean? (member user (select-user-register(select-user system))))
     (list (select-system-InicialChatbotCodeLink system)
           (list(append(select-user-register(select-user system))
                    (list user ))
             (select-user-login(select-user system)))
          (append(select-system-chathistory system)(list(list)))
          (select-system-name system)(select-system-option-chatbots system)
          (select-system-option-flows system) (select-system-option-keywords system)
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
     (list (select-system-InicialChatbotCodeLink sys) 
           (list (select-user-register(select-user sys))
                 (append (select-user-login(select-user sys))
                         (list user)))
           (select-system-chathistory sys)
           (select-system-name sys)(select-system-option-chatbots sys)
           (select-system-option-flows sys) (select-system-option-keywords sys)
           (select-system-chatbot sys))
        sys))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (system-logout sys)
  (list (select-system-InicialChatbotCodeLink sys)
        (list (select-user-register(select-user sys))
              (list))
        (select-system-chathistory sys)
        (select-system-name sys)(list)
        (list) (list)
        (select-system-chatbot sys)))

#|..........................Otros..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (system-talk-rec system message)
  (if(not(empty? (select-user-login(select-user system))))
     (if(empty?(select-system-option-keywords system))
        (search-rec system
                          (select-system-chatbot system)
                          (select-system-InicialChatbotCodeLink system)
                          (get-inicialFlowId(select-system-chatbot system)(select-system-InicialChatbotCodeLink system)) 
                          (list (~a(current-seconds))"-"(get-user-login(select-user system))": " message "\n"))
        (search-rec system (select-system-chatbot system)
                    (list-ref (select-system-option-chatbots system)
                              (index-where(select-system-option-keywords system)
                                          (lambda(keyword)(string-contains? keyword (string-downcase message)))))
                    (list-ref (select-system-option-flows system)
                              (index-where(select-system-option-keywords system)
                                          (lambda(keyword)(string-contains? keyword (string-downcase message))))) 
                    (list (~a(current-seconds))"-"(get-user-login(select-user system))": " message "\n")))
     system))
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(search-rec system tdas id1 id2 history)
  (cond
       [(chatbot? (car tdas))
        (if(equal? id1 (select-chatbot-id (car tdas)))
           (search-rec system (select-chatbot-flow (car tdas)) "-" id2
                             (append history (list (~a(current-seconds))"-" (select-chatbot-name (car tdas))" ")))
           (search-rec system (cdr tdas) id1 id2 history))]
       [(flow?(car tdas))
        (if(equal? id2 (select-flow-id(car tdas)))
           (list (select-system-InicialChatbotCodeLink system)
                 (select-user system)
                 (list-set (select-system-chathistory system)
                           (index-of(select-user-register(select-user system))(get-user-login(select-user system)))
                           (append(list-ref (select-system-chathistory system)
                                            (index-of(select-user-register(select-user system))
                                                     (get-user-login(select-user system))))
                                  history
                                  (list (select-flow-name (car tdas)) "\n")
                                  (map (lambda(message)(string-append message"\n"))
                                       (map select-option-message (select-flow-Option (car tdas))))))
               (select-system-name system)(get-option-chatbots-ids(select-flow-Option(car tdas)))
               (get-option-flows-ids(select-flow-Option(car tdas)))(get-option-Keyword(select-flow-Option(car tdas)))(select-system-chatbot system))
           (search-rec system (cdr tdas) id1 id2 history))]))


;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (system-talk-norec system message)
  (if(not(empty?(select-user-login(select-user system))))
     (if(empty?(select-system-option-keywords system))
        (let([chatbot(list-ref (select-system-chatbot system)
            (index-of (get-chatbot-ids (select-system-chatbot system))
                      (select-system-InicialChatbotCodeLink system)))])
            (let([flow(list-ref (select-chatbot-flow chatbot)
                                (index-of (get-flow-ids (select-chatbot-flow chatbot))
                                (select-chatbot-sFId chatbot)))])
                (list (select-system-InicialChatbotCodeLink system)
                      (select-user system)
                      (list-set (select-system-chathistory system)
                         (index-of(select-user-register(select-user system))(get-user-login(select-user system)))
                         (append(list-ref (select-system-chathistory system)(index-of(select-user-register(select-user system))
                                                                           (get-user-login(select-user system))))
                              (list (string-append (~a(current-seconds))"-"(get-user-login(select-user system))": " message "\n"
                                                   (~a(current-seconds))"-" (select-chatbot-name chatbot)" "
                                                    (select-flow-name flow) "\n"))
                              (map (lambda(message)(string-append message"\n"))
                                   (map select-option-message (select-flow-Option flow)))))
                      (select-system-name system)
                      (get-option-chatbots-ids(select-flow-Option flow))
                      (get-option-flows-ids(select-flow-Option flow))
                      (get-option-Keyword(select-flow-Option flow))
                      (select-system-chatbot system))))
          
        (let([chatbot(list-ref (select-system-chatbot system)
            (index-of (get-chatbot-ids (select-system-chatbot system))
                      (list-ref (select-system-option-chatbots system)
                              (index-where(select-system-option-keywords system)
                                          (lambda(keyword)(string-contains? keyword (string-downcase message)))))))])
            (let([flow(list-ref (select-chatbot-flow chatbot)
                                (index-of (get-flow-ids (select-chatbot-flow chatbot))
                                          (list-ref (select-system-option-flows system)
                                          (index-where(select-system-option-keywords system)
                                          (lambda(keyword)(string-contains? keyword (string-downcase message)))))))])
                (list (select-system-InicialChatbotCodeLink system)
                      (select-user system)
                      (list-set (select-system-chathistory system)
                         (index-of(select-user-register(select-user system))(get-user-login(select-user system)))
                         (append(list-ref (select-system-chathistory system)(index-of(select-user-register(select-user system))
                                                                           (get-user-login(select-user system))))
                              (list (string-append (~a(current-seconds))"-"(get-user-login(select-user system))": " message "\n"
                                                   (~a(current-seconds))"-" (select-chatbot-name chatbot)" "
                                                    (select-flow-name flow) "\n"))
                              (map (lambda(message)(string-append message"\n"))
                                   (map select-option-message (select-flow-Option flow)))))
                      (select-system-name system)
                      (get-option-chatbots-ids(select-flow-Option flow))
                      (get-option-flows-ids(select-flow-Option flow))
                      (get-option-Keyword(select-flow-Option flow))
                      (select-system-chatbot system)))))
     system))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(system-synthesis system user)
  (list-ref (select-system-chathistory system)
            (index-of (select-user-register(select-user system))user) ))

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

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
(define (get-inicialFlowId chatbots id)
  (let([chatbot (list-ref chatbots (index-of(get-chatbot-ids chatbots)id))])
   (select-chatbot-sFId chatbot)))
