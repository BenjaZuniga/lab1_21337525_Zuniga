#lang racket
(provide(all-defined-out))

(define user (list (list)(list)))


(define(select-user-register user )(car user))

(define(select-user-login user)(cadr user))