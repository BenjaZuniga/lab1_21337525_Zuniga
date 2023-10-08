#lang racket
(require "TDAOption_21337525_ZunigaJofre.rkt")
(require "TDAFlow_21337525_ZunigaJofre.rkt")
(require "TDAChatbot_21337525_ZunigaJofre.rkt")
(require "TDAUser_21337525_ZunigaJofre.rkt")
(require "TDAChathistory_21337525_ZunigaJofre.rkt")
(provide(all-defined-out))

#|..........................Especificación TDA System..........................|#
;system = IncialChatbotCodeLink X user X chathistory X name X option-chatbots X option-flows X option-keywords X chatbot
;IniciañChatbotCodeLink = int
;user = user
;chathistory = chathistory
;name = string
;option-chatbots = null | ChatbotCodeLink X option-chatbots
;option-flows = null | InicialFlowCodeLink X option-flows
;option-keywords = null | Keyword X option-keywords
;chatbot = null | TDA Chatbot x chatbot
 
#|..........................Constructor..........................|#
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

#|..........................Pertenencia..........................|#

#|..........................Selector..........................|#
;Nombre de la función: select-system-InicialChatbotCodeLink
;Dominio: system
;Recorrido: InicialChatbotCodeLink
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el InicialChatbotCodeLink de un system
(define (select-system-InicialChatbotCodeLink sys)(car sys))

;Nombre de la función: select-system-user
;Dominio: system
;Recorrido: user
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el user de un system
(define (select-system-user sys)(cadr sys))

;Nombre de la función: select-system-chathistory
;Dominio: system
;Recorrido: chathistory
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el chathistory de un system
(define (select-system-chathistory sys)(caddr sys))

;Nombre de la función: select-system-name
;Dominio: system
;Recorrido: name
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el name de un system
(define(select-system-name sys)(cadddr sys))

;Nombre de la función: select-system-option-chatbots
;Dominio: system
;Recorrido: option-chatbots
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el option-chatbots de un system
(define(select-system-option-chatbots sys)(list-ref sys 4))

;Nombre de la función: select-system-option-flows
;Dominio: system
;Recorrido: option-flow
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el option-flows de un system
(define(select-system-option-flows sys)(list-ref sys 5))


;Nombre de la función: select-system-option-keywords
;Dominio: system
;Recorrido: option-keyword
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el option-keywords de un system
(define(select-system-option-keywords sys)(list-ref sys 6))

;Nombre de la función: select-system-chatbot
;Dominio: system
;Recorrido: chatbot
;Tipo de recursion: Ninguna
;Descripción de la función: Selecciona el chatbot de un system
(define(select-system-chatbot sys)(list-ref sys 7))

#|..........................Modificador..........................|#
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

#|..........................Otros..........................|#
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
;Nombre de la función: search-rec
;Dominio: system X tdas X id1 X id2 X history
;Recorrido: system
;Tipo de recursion: Cola
;Descripción de la función: Busca recursivamente el id del chatbot y el flow que corresponden al message de
; la función system-talk-rec, devuelve un system con los ids de los chatbots y flows, y las keyword del
; flow que se estaba buscando
(define(search-rec system tdas id1 id2 history)
  (cond
       [(chatbot? (car tdas))
        (if(equal? id1 (select-chatbot-id (car tdas)))
           (search-rec system (select-chatbot-flow (car tdas)) "-" id2
                             (append history (list (~a(current-seconds))"-" (select-chatbot-name (car tdas))":")))
           (search-rec system (cdr tdas) id1 id2 history))]
       [(flow?(car tdas))
        (if(equal? id2 (select-flow-id(car tdas)))
           (list (select-system-InicialChatbotCodeLink system)
                 (select-system-user system)
                 (list-set (select-system-chathistory system)
                           (index-of(select-user-register(select-system-user system))(get-user-login(select-system-user system)))
                           (append(list-ref (select-system-chathistory system)
                                            (index-of(select-user-register(select-system-user system))
                                                     (get-user-login(select-system-user system))))
                                  history
                                  (list (select-flow-name (car tdas)) "\n")
                                  (map (lambda(message)(string-append message"\n"))
                                       (map select-option-message (select-flow-Option (car tdas))))))
               (select-system-name system)(get-option-chatbots-ids(select-flow-Option(car tdas)))
               (get-option-flows-ids(select-flow-Option(car tdas)))(get-option-Keyword(select-flow-Option(car tdas)))(select-system-chatbot system))
           (search-rec system (cdr tdas) id1 id2 history))]))


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

;Nombre de la función: myRandom
;Dominio: int
;Recorrido: int
;Tipo de recursion: Ninguna
;Descripción de la función: Genera un numero pseudoaleatorio respetando el principio de
; transparencia referencial
(define (myRandom Xn)
  (modulo (+ (* 1103515245 Xn) 12345) 2147483648))



;Nombre de la función: new-chatbot
;Dominio: chatbot
;Recorrido: chatbot
;Tipo de recursion: natural
;Descripción de la función: Se ingresa un chatbot de un system compuesto de chatbots y se reconstruye eliminando
; los chatbots con ids repetidos en caso de que haya, dejando un solo chatbot con el id que estaba repetido
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


;Nombre de la función: get-chatbot-ids
;Dominio: chtabot
;Recorrido: list
;Tipo de recursion: Ninguna
;Descripción de la función: Obtiene los ids sin duplicados dechatbots que compones un chatbot de un system
(define (get-chatbot-ids chatbot)
  (if(not(null? chatbot))
     (remove-duplicates (map select-chatbot-id chatbot))
     (list)))

;Nombre de la función: get-inicalFlowId
;Dominio:chatbot X id
;Recorrido: startFlowId
;Tipo de recursion:
;Descripción de la función: Obtiene el startFlowId del Chatbot incial del system dado por
; el IncialChabotCodeLink del system
(define (get-inicialFlowId chatbots id)
  (let([chatbot (list-ref chatbots (index-of(get-chatbot-ids chatbots)id))])
   (select-chatbot-sFId chatbot)))

;Nombre de la función: maxOptions
;Dominio: system
;Recorrido: int
;Tipo de recursion: Ninguna
;Descripción de la función: Obtiene el numero maximo de opciones en un system mediante
; el largo de option-keywords de system
(define (maxOptions system) (-(length (select-system-option-keywords system)) 1))




