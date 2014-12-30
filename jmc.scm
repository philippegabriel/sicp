;;the original lisp interpreter from John McCarthy
;;as presented in "The Roots of Lisp", Paul graham
;;http://www.paulgraham.com/rootsoflisp.html
;;Following are Scheme macros and functions, to define the primitives 
;;
;;quote - no translation
;;atom
(define (atom x) 
		(cond	((eq? x ()) 't)
			((list? x) '())
			(else	   't)))
(atom '())
(atom '(a))
(atom 'a)
;;eq
(define (eq x y) (if (eq? x y) 't ()))
(eq 'a 'a)
(eq 'a 'b)
(eq 't ())
;;car,cdr,cons - no translation
;;cond
(define-syntax cond.
	(syntax-rules ()
		((cond.) ())
		((cond. (p1 x) (p2 y) ...) (if (eq? p1 't) x (cond. (p2 y) ... )))
	)
)
(cond. ('t 'a))
(cond. ('() 'a) ('t 'b))
(cond. ((eq 'a 'b) '1st) ((eq 'a 'a) '2nd) ((eq 'a 'b) '3rd))
(cond. ((atom '(a b)) '1st) ((atom 'a) '2nd))
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
(defun f (x) (cond. ((eq x 0) 0) ('t (+ x (f (- x 1))))))
(f 3)
(defun a (x) (atom x))
(a 1)
(defun subst (x y z)
	(cond.	((eq z '()) '())
		((atom z)
			(cond. 	((eq z y) x)
				('t z)))
		('t (cons (subst x y (car z)) (subst x y (cdr z))))))

(subst 'm 'b '(a b (a b c) d))
;null.
(defun null. (x)
	(eq x '()))
(null. 'a)
(null. '())

;and
(defun and. (x y)
	(cond. 	(x (cond. (y 't) ('t '())))
		('t '())))
(and. (atom 'a) (eq 'a 'a))
(and. (atom 'a) (eq 'a 'b))

;not.
(defun not. (x)
	(cond. 	(x '())
		('t 't)))
(not. (eq 'a 'a))
(not. (eq 'a 'b))

;append
(defun append. (x y)
	(cond. 	((null. x) y)
		('t (cons (car x) (append. (cdr x) y)))))
(append. '(a b) '(c d))
(append. '() '(c d))

(exit) y

