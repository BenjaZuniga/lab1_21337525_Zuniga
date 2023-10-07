#lang racket
(require "TDAOption_21337525_ZunigaJofre.rkt")
(require "TDAFlow_21337525_ZunigaJofre.rkt")
(require "TDAChatbot_21337525_ZunigaJofre.rkt")
(require "TDAUser_21337525_ZunigaJofre.rkt")
(require "TDAChathistory_21337525_ZunigaJofre.rkt")
(require "TDASystem_21337525_ZunigaJofre.rkt")
(provide (all-defined-out))


;Nombre de la función: option
;Dominio: code (Int)  X message (String)  X ChatbotCodeLink (Int) X InitialFlowCodeLink (Int) X Keyword*
;Recorrido: option
;Tipo de recursion: Ninguna
;Descripción de la función: Crea el TDA Option
(define (option code message ChatbotCodeLink InicialFlowCodeLink . Keyword)
     (list code message ChatbotCodeLink InicialFlowCodeLink
           (append (map string-downcase Keyword)(list(~a(string-ref message 0))))))

;Nombre de la función: flow
;Dominio: id (int) X name-msg (String)  X Option*
;Recorrido: flow
;Tipo de recursion: Natural de la funcion new-Option
;Descripción de la función: Crea un TDA Flow y verifica que en Option no hayan opciones repetidas
;en base a sus ids
(define (flow id name . Option)
  (list id name (if(not(null? Option))
                   (remove (list)(new-Option Option))
                   Option)))

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

;Nombre de la función: chatbot
;Dominio: chatbotID (int) X name (String) X welcomeMessage (String) X startFlowId(int) X  flows
;Recorrido: chatbot
;Tipo de recursion: Natural de la funcion new-flow
;Descripción de la función: Crea un chatbot
(define (chatbot id name welcomeMessage startFlowId . flows)
  (list id name welcomeMessage startFlowId (if(not(null? flows))
                                           (remove (list)(new-flows flows))
                                           flows)))

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


;Nombre de la función: system
;Dominio: name (string) X InitialChatbotCodeLink (Int) X chatbot*
;Recorrido: system
;Tipo de recursion: Natural, de la función new-chatbot
;Descripción de la función: Crea un system
(define (system name InicialChatbotCodeLink . chatbot)
  (list InicialChatbotCodeLink user chathistory name
        (list) (list) (list)(if(not(null? chatbot))
                               (remove (list)(new-chatbot chatbot))
                                chatbot)))

;Nombre de la función: system-add-chatbot
;Dominio: system X chatbot
;Recorrido: system
;Tipo de recursion: Ninguna
;Descripción de la función: Verifica si un chatbot está en un chatbot de un system en base a su id,
; y si no está reconstruye un system con el nuevo chatbot, si el id está repetido devuelve
; el system como estaba
(define(system-add-chatbot system chatbot)
 (if(boolean?(member (select-system-InicialChatbotCodeLink chatbot)
                     (get-chatbot-ids (select-system-chatbot system))))
    (list (select-system-InicialChatbotCodeLink system)(select-system-user system)
          (select-system-chathistory system)
          (select-system-name system)(select-system-option-chatbots system)
          (select-system-option-flows system) (select-system-option-keywords system)
          (append (select-system-chatbot system)(list chatbot)))
    system))


;Nombre de la función: system-add-user
;Dominio: system X user
;Recorrido: system
;Tipo de recursion: Ninguna
;Descripción de la función: Se ingresa un system y un user, y se registra en el user del system
; en caso de que este no esté registrado, si ya está registrado devuelve el system como estaba, con
; un solo registro en el system del user
(define (system-add-user system user)
  (if(boolean? (member user (select-user-register(select-system-user system))))
     (list (select-system-InicialChatbotCodeLink system)
           (list(append(select-user-register(select-system-user system))
                    (list user ))
             (select-user-login(select-system-user system)))
          (append(select-system-chathistory system)(list(list)))
          (select-system-name system)(select-system-option-chatbots system)
          (select-system-option-flows system) (select-system-option-keywords system)
          (select-system-chatbot system))
     system))
    

;Nombre de la función: system-login
;Dominio: system X user
;Recorrido: system
;Tipo de recursion: Ninguna
;Descripción de la función: Deja un user como logeado dentro del system en caso de que no haya un user
; logeado y el user esté en los registrados del system
(define(system-login sys user)
  (if(and(empty? (select-user-login(select-system-user sys)))
         (not(boolean? (member user (select-user-register(select-system-user sys))))))
     (list (select-system-InicialChatbotCodeLink sys) 
           (list (select-user-register(select-system-user sys))
                 (append (select-user-login(select-system-user sys))
                         (list user)))
           (select-system-chathistory sys)
           (select-system-name sys)(select-system-option-chatbots sys)
           (select-system-option-flows sys) (select-system-option-keywords sys)
           (select-system-chatbot sys))
        sys))

;Nombre de la función: system-logout
;Dominio: system
;Recorrido: system
;Tipo de recursion: Ninguna
;Descripción de la función: Devuelve el system con un user
(define (system-logout sys)
  (list (select-system-InicialChatbotCodeLink sys)
        (list (select-user-register(select-system-user sys))
              (list))
        (select-system-chathistory sys)
        (select-system-name sys)(list)
        (list) (list)
        (select-system-chatbot sys)))


;Nombre de la función: system-talk-rec
;Dominio: system X message
;Recorrido: system
;Tipo de recursion: Cola, de la función search-rec
;Descripción de la función: Pertmite a un usuario logeado hablar con el system, en caso de que no haya un
; usuario logeado se devuelve el system como estaba, en caso de que haya un usuario logeado
; si no se ha iniciado una conversacion se devuelven las optiones que contienen el flujo inicial del system
; y en el system se guardan los ids de los chatbots, flows y keywords asociados a las opciones del flujo
; inicial, en caso de que hay una coversación iniciada se busca el message en las option-keyword del system
; y se buscan las nuevas opciones con los ids de chatbots y flows asociados a las option-keywords, mediante
; la función search-rec y almacena la conversacion en un historial unico que corresponde al usuario logeado
(define (system-talk-rec system message)
  (if(not(empty? (select-user-login(select-system-user system))))
     (if(empty?(select-system-option-keywords system))
        (search-rec system
                          (select-system-chatbot system)
                          (select-system-InicialChatbotCodeLink system)
                          (get-inicialFlowId(select-system-chatbot system)(select-system-InicialChatbotCodeLink system)) 
                          (list (~a(current-seconds))"-"(get-user-login(select-system-user system))": " message "\n"))
        (search-rec system (select-system-chatbot system)
                    (list-ref (select-system-option-chatbots system)
                              (index-where(select-system-option-keywords system)
                                          (lambda(keywords)(list? (member (string-downcase message) keywords)))))
                    (list-ref (select-system-option-flows system)
                              (index-where(select-system-option-keywords system)
                                          (lambda(keywords)(list? (member (string-downcase message) keywords))))) 
                    (list (~a(current-seconds))"-"(get-user-login(select-system-user system))": " message "\n")))
     system))

;Nombre de la función: system-talk-norec
;Dominio: system X message
;Recorrido: system
;Tipo de recursion: Ninguna
;Descripción de la función: Funciona igual que system-talk-rec sin recursion, permitiendo al usuario logeado
; hablar con el sistema y almacenando la conversacion en un historial
(define (system-talk-norec system message)
  (if(not(empty?(select-user-login(select-system-user system))))
     (if(empty?(select-system-option-keywords system))
        (let([chatbot(list-ref (select-system-chatbot system)
            (index-of (get-chatbot-ids (select-system-chatbot system))
                      (select-system-InicialChatbotCodeLink system)))])
            (let([flow(list-ref (select-chatbot-flow chatbot)
                                (index-of (get-flow-ids (select-chatbot-flow chatbot))
                                (select-chatbot-sFId chatbot)))])
                (list (select-system-InicialChatbotCodeLink system)
                      (select-system-user system)
                      (list-set (select-system-chathistory system)
                         (index-of(select-user-register(select-system-user system))(get-user-login(select-system-user system)))
                         (append(list-ref (select-system-chathistory system)(index-of(select-user-register(select-system-user system))
                                                                           (get-user-login(select-system-user system))))
                              (list (string-append (~a(current-seconds))"-"(get-user-login(select-system-user system))": " message "\n"
                                                   (~a(current-seconds))"-" (select-chatbot-name chatbot)":"
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
                                          (lambda(keywords)(list? (member (string-downcase message) keywords)))))))])
            (let([flow(list-ref (select-chatbot-flow chatbot)
                                (index-of (get-flow-ids (select-chatbot-flow chatbot))
                                          (list-ref (select-system-option-flows system)
                                          (index-where(select-system-option-keywords system)
                                          (lambda(keywords)(list? (member (string-downcase message) keywords)))))))])
                (list (select-system-InicialChatbotCodeLink system)
                      (select-system-user system)
                      (list-set (select-system-chathistory system)
                         (index-of(select-user-register(select-system-user system))(get-user-login(select-system-user system)))
                         (append(list-ref (select-system-chathistory system)(index-of(select-user-register(select-system-user system))
                                                                           (get-user-login(select-system-user system))))
                              (list (string-append (~a(current-seconds))"-"(get-user-login(select-system-user system))": " message "\n"
                                                   (~a(current-seconds))"-" (select-chatbot-name chatbot)":"
                                                    (select-flow-name flow) "\n"))
                              (map (lambda(message)(string-append message"\n"))
                                   (map select-option-message (select-flow-Option flow)))))
                      (select-system-name system)
                      (get-option-chatbots-ids(select-flow-Option flow))
                      (get-option-flows-ids(select-flow-Option flow))
                      (get-option-Keyword(select-flow-Option flow))
                      (select-system-chatbot system)))))
     system))

;Nombre de la función: system-synthesis
;Dominio: system X user
;Recorrido: string
;Tipo de recursion: Ninguna
;Descripción de la función: Devuelve el string que corresponde al historial del usuario ingresado, en caso
;de que no exista el usuario devuelve un mensaje en especial
(define(system-synthesis system user)
  (if(list? (member user (select-user-register(select-system-user system))))
     (list-ref (select-system-chathistory system)
            (index-of (select-user-register(select-system-user system))user))
  "No existe el usuario ingresado en el sistema\n"))

;Nombre de la función: system-simulate
;Dominio: system X maxInteractions X seed
;Recorrido: system
;Tipo de recursion: Natural de la función interna y Cola de system-talk-rec
;Descripción de la función: Permite simular unas interacciones psudoaleatorias con un system
; mediante una seed, el numero maximo de interacciones está dado por maxInteracions y dependiendo
; de la seed la conversación generada es distinta, pero se asegura que la simulación es la misma
; si la seed es la misma gracias a la función myRandom
(define system-simulate (lambda(system maxInteractions seed)
  (define system-simulate-int(lambda(system maxInteractions original-seed seed)
   (if(= maxInteractions 0)
     system
     (cond
       [(equal? (string-append "user" (~a original-seed)) (get-user-login (select-system-user system)))
        (system-simulate-int(system-talk-norec system (number->string(+ 1(modulo (myRandom seed)
                                                                              (maxOptions system)))))
                         (- maxInteractions 1)
                         original-seed
                         (myRandom seed))]
       [(empty?(select-user-login (select-system-user system)))
        (system-simulate-int(system-talk-rec (system-login (system-add-user system
                                                                          (string-append "user" (~a seed)))
                                                         (string-append "user" (~a seed)))
                                         "Hola")
                                         maxInteractions
                                         original-seed
                                         seed)]
       [(not(empty?(select-user-login (select-system-user system))))
        (system-simulate-int(system-talk-rec (system-login (system-add-user (system-logout system)
                                                                        (string-append "user" (~a seed)))
                                                       (string-append "user" (~a seed)))
                                         "Hola")
                        maxInteractions
                        original-seed
                        seed)]))))
  (system-simulate-int system maxInteractions seed seed)))
