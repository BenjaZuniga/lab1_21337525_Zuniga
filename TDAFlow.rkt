#|..........................TDA Flow..........................|#

#|..........................Constructor..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (flow id name . Option)
  (list id name (if(not(null? Option))
                   (remove (list)(new-Option Option))
                   Option)))


#|..........................Pertenecia..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (flow? flow)
  (if(integer? (select-flow-id flow))
     (if(string? (select-flow-name flow))
        (if(or (map option?(select-flow-Option flow))
               (null? (select-flow-Option flow)))
        #t #f)#f)#f))
#|..........................Selectores..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(select-flow-id flow)(car flow))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (select-flow-name flow)(cadr flow))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (select-flow-Option flow)(caddr flow))

#|..........................Modificadores..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define(flow-add-option flow option)
 (if(boolean?(member (select-option-code option)
                     (get-option-ids (select-flow-Option flow))))
    (list (select-flow-id flow)(select-flow-name flow)
          (append (select-flow-Option flow)(list option)))
    flow))

#|..........................Otros..........................|#
;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define new-Option(lambda(option)
  (define create-Option(lambda(option ids)
    (if(not (null? (cdr option)))
       (if (list?(member (select-option-code (car option)) ids))
        (cons(car option)(create-Option(cdr option)(remove (select-option-code (car option)) ids)))
        (create-Option(cdr option) ids ))
       (if (list?(member (select-option-code (car option)) ids))
        (cons(car option) null)
        (cons null null )))))
                    (create-Option option (get-option-ids option))))

;Nombre de la función:
;Dominio:
;Recorrido:
;Tipo de recursion:
;Descripción de la función:
(define (get-option-ids option)
  (if(not(null? option))
     (remove-duplicates (map select-option-code option))
     (list)))
