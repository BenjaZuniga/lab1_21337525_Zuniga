#lang racket
(provide (all-defined-out))

#|TDA Option|#



#|Constructor|#
(define (option code message ChatbotCodeLink FlowCodeLink . Keyword)
  (if(option?(list code message ChatbotCodeLink FlowCodeLink Keyword))
     (list code message ChatbotCodeLink FlowCodeLink Keyword)
     "Los parametros ingresados no corresponden " ))

#|Pertenencia|#
(define(option? op) (if(integer? (select-code op))
                       (if(string? (select-message op))
                          (if(integer? (select-ChatbotCodeLink op))
                             (if(integer? (select-FlowCodeLink op))
                                (if(or (map string?(select-Keyword op))
                                       (map null?(select-Keyword op)))
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
