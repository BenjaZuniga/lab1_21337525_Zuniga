#lang racket
(require "TDAOpcion.rkt")
(provide (all-defined-out))
#|Flow|#

#|Constructor|#
(define (flow name . Option)(list name Option))
#|Modificadores|#
(define(flow-add-option flow option)(append(cadr(flow))option))

#|Selectores|#
;SelectName
(define (SelectName flow)(car flow))
;SelectOption
(define (SelectOption flow)(cadr flow))
