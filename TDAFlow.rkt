#lang racket
(require "TDAOption.rkt")
(provide (all-defined-out))
#|Flow|#

#|Constructor|#
(define (flow name . Option)
  (if(flow? (list name Option))
            (if(integer? (option-uniques-id (list name Option)))
               "IDs de opciones repetidos"
               (list name Option))
            "Los parametros ingresados no son validos"))
#|Pertenecia|#
(define (flow? flow)
  (if(string? (SelectName flow))
     (if(or (map option?(SelectOption flow))(map empty? (SelectOption flow)))
        #t #f)#f))
#|Selectores|#

(define(SelectId flow)(car flow))

(define (SelectName flow)(car flow))

(define (SelectOption flow)(cadr flow))

#|Modificadores|#
(define(flow-add-option fl option)
  (if(integer?
      (option-uniques-id(list (SelectName fl)
                              (append(SelectOption fl) (list option)))))
     "IDs de opciones repetidos"
     (list (SelectName fl) (append(SelectOption fl) (list option)))))

#|Otros|#
(define (option-uniques-id flow)
  (check-duplicates(append(list )
                          (map select-code(SelectOption flow)))
                   #:default #t))
