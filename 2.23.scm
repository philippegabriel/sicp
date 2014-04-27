(for-each (lambda (x) (newline) (display x)) (list 57 321 88))

(define (my-for-each f items)
 	(if (null? items)
		()
		(begin (f (car items)) (my-for-each f (cdr items)))
	)
)
(my-for-each (lambda (x) (newline) (display x)) (list 57 321 88))

		

