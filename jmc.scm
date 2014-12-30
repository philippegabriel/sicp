;;the original lisp interpreter from John McCarthy
;;as presented in "The Roots of Lisp", Paul graham
;;http://www.paulgraham.com/rootsoflisp.html
;;Following are Scheme macros and functions, to define the primitives 
;;
;;quote - no translation
;;atom
(define (atom x) 
	(cond	((eq? x ())	't)
			((list? x)	'())
			(else		't)
	)
)
(atom '())
(atom '(a))
(atom 'a)
;;eq
(define (eq x y) (if (eq? x y) 't ()))
(eq 'a 'a)
(eq 1 2)
(eq 't ())
;;car,cdr - no translation
;;cons - no translation
;;cond
(define-syntax cond.
	(syntax-rules ()
		((cond.) ())
		((cond. (p1 x) (p2 y) ...) (if p1 x (cond. (p2 y) ... )))
	)
)
't
''t
'('t 'b)
(car '('t b))
(equal? (car '('t b)) ''t)
(cond. ('t 'a))
(eq 'a 'a)
(cond. ((eq 'a 'a) 'arg1))
(eq 'a 'b)
(cond. ((eq 'a 'b) 'arg1))
(cond. ((eq 'a 'b) 'first) ((atom 'a) 'second))
(let ((x 1)) (cond. ((= 1 x)2)))
;;list - no translation
;;defun
(define-syntax defun
  (syntax-rules ()
    ((defun name args body)
     (define name (lambda args body))
    )
  )
)
(defun f (x y) (+ y x))
(f 100 20)
(defun f (x) (if (= x 0) 0 (+ x (f (- x 1)))))
(f 3)
(defun a (x) (atom x))
(a 1)
(defun f (x) (cond. ((= x 1)x)(#t 0)))
(f 1)
(defun subst (x y z)
	(cond.	((atom z)
			(cond. 	((eq z y) x)
				('t z)))
		('t (cons (subst x y (car z)) (subst x y (cdr z))))))

;(subst 'm 'b '(a b (a b c) d))
(subst 'm 'b 'b)
(subst 'm 'b '(a b))
(exit) y

