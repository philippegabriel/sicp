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
(define-syntax eq
	(syntax-rules ()
		((eq x y) (if (eq? x y) 't ()))
	)
)
(eq 'a 'a)
(eq 1 2)
(eq 't ())
;;car,cdr - no translation
;;cons - no translation
;;cond
(define-syntax cond
	(syntax-rules ()
		((cond) ())
		((cond x y ...)
			(let ((pred (car 'x)))
			(if (eval pred user-initial-environment) (cadr 'x) (cond y ...))))
	)
)
(cond ((eq? 'a 'a) 1stArg))
(cond ((eq? 'a 'b) 1stArg)(#t 2ndArg))
(cond ((eq 'a 'b) 'first) ((atom 'a) 'second))
(let ((x 1)) (cond ((= 1 x)2)))
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
(defun f (x) (cond ((= x 1)x)(#t 0)))
(f 1)


