#lang racket
(provide(all-defined-out))

(define chathistory (list ))

(define (get-chat-index chathistory user)
  (index-of user (map car chathistory)))

(define (find-chathistory chathistory user)
  (cadr(list-ref chathistory (get-chat-index chathistory user))))