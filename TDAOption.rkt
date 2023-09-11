#lang racket
(provide (all-defined-out))

#|TDA Option|#



#|Constructor|#
(define (option code message ChatbotCodeLink FlowCodeLink . Keyword)
  (list code message ChatbotCodeLink FlowCodeLink Keyword))

#|Pertenencia|#
(define(option? op) (if(integer? (select-code op))
                       (if(string? (select-message op))
                          (if(integer? (select-ChatbotCodeLink op))
                             (if(integer? (select-FlowCodeLink op))
                                (if(map string?(select-Keyword op))
                                        #t #f)#f)#f)#f)#f)) 
#|Selectores|#
;SelectCode
(define(select-code op)(car op))
;SelectMessage
(define(select-message op)(cadr op))
;SelectChatbotCodeLink
(define(select-ChatbotCodeLink op)(caddr op))
;SelectFlowCodeLink
(define(select-FlowCodeLink op)(cadddr op))
;SelectKeyword
(define(select-Keyword op)(list-ref op 4))

#|Modificadores|#
