#lang racket
(require "TDAOption.rkt")
(require "TDAFlow.rkt")
(require "TDAChatbot.rkt")

#|Constructor|#
(define (system name . chatbot)
  (list (list ) (list ) name chatbot))

#|Pertenencia|#
#|Selector|#
(define (select-chathistory sys)(car sys))
(define (select-user sys)(cadr sys))
(define (select-system-name sys)(caddr sys))
(define(select-chatbot sys)(cadddr sys))
#|Modificador|#

(define(system-add-chatbot sys cb)(append(select-chatbot sys)(list cb)))

(define (system-add-user sys user)(append(select-user sys)(list user)))


(define(system-login sys user)
  (if(map (equal? user (select-user sys)))
     (if(map (equal? 1 (select-user sys)))
        (list (list) (append 1 (select-user sys))
              (select-system-name sys) (select-chatbot sys))
        "Hay un usuario activo")
     "Usuario no registrado"))

(define (system-logout sys)
  (list (select-chathistory sys)(remove 1 (select-user sys))
        (select-system-name sys)(select-chatbot sys)))

#|Otros|#
(define (chatbot-uniques-id sys)
  (check-duplicates(append(list )
                          (map select-chatbot-id(select-chatbot sys)))
                   #:default #t))