;;the original lisp interpreter from John McCarthy
;;as presented in "The Roots of Lisp", Paul graham
;;http://www.paulgraham.com/rootsoflisp.html
;;Following are Scheme macros and functions, to define the primitives 
;;Of the 7 primitives presented in the paper
;;quote, car, cdr, cons : map on the scheme special forms
;;to cope with #t and #f defined as 't and ()
;;cond is redefined as a macro, eq is redefined as a function, atom is defined as a function
;;defun is defined as a macro
 
;;atom
(define (atom x) 
		(if	(null? x ) 't 
			(if (list? x) '() 't)))
(atom '())
(atom '(a))
(atom 'a)
;;eq
(define (eq x y) (if (eq? x y) 't ()))
(eq 'a 'a)
(eq 'a 'b)
(eq 't ())
;;cond
(define-syntax cond
	(syntax-rules ()
		((cond) ())
		((cond (p1 x) (p2 y) ...) (if (eq? p1 't) x (cond (p2 y) ... )))
	)
)
(cond ('t 'a))
(cond ('() 'a) ('t 'b))
(cond ((eq 'a 'b) '1st) ((eq 'a 'a) '2nd) ((eq 'a 'b) '3rd))
(cond ((atom '(a b)) '1st) ((atom 'a) '2nd))
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
(defun f (x) (cond ((eq x 0) 0) ('t (+ x (f (- x 1))))))
(f 3)
(defun a (x) (atom x))
(a 1)
(defun subst (x y z)
	(cond	((eq z '()) '())
		((atom z)
			(cond 	((eq z y) x)
				('t z)))
		('t (cons (subst x y (car z)) (subst x y (cdr z))))))

(subst 'm 'b '(a b (a b c) d))
;null.
(defun null. (x)
	(eq x '()))
(null. 'a)
(null. '())

;and.
(defun and. (x y)
	(cond 	(x (cond (y 't) ('t '())))
		('t '())))
(and. (atom 'a) (eq 'a 'a))
(and. (atom 'a) (eq 'a 'b))

;not.
(defun not. (x)
	(cond 	(x '())
		('t 't)))
(not. (eq 'a 'a))
(not. (eq 'a 'b))

;append.
(defun append. (x y)
	(cond 	((null. x) y)
		('t (cons (car x) (append. (cdr x) y)))))
(append. '(a b) '(c d))
(append. '() '(c d))
;pair
(defun pair. (x y)
	(cond	((and. (null. x) (null. y)) '())
			((and. (not. (atom x)) (not. (atom y)))
				(cons (list (car x) (car y))
					(pair. (cdr x) (cdr y))))))
(pair. '(x y z) '(a b c))
;assoc.
(defun assoc. (x y)
	(cond	((eq (caar y) x) (cadar y))
			('t (assoc. x (cdr y)))))
(assoc. 'x '((x a) (y b)))
(assoc. 'x '((x new) (x a) (y b)))

;eval.
(defun eval. (e a)
	(cond
		((atom e) (assoc. e a))
		((atom (car e))
		(cond
			((eq (car e) 'quote)	(cadr e))
			((eq (car e) 'atom)		(atom (eval. (cadr e) a)))
			((eq (car e) 'eq)		(eq	(eval. (cadr e) a)
										(eval. (caddr e) a)))
			((eq (car e) 'car)		(car	(eval. (cadr e) a)))
			((eq (car e) 'cdr)		(cdr	(eval. (cadr e) a)))
			((eq (car e) 'cons)		(cons	(eval. (cadr e) a)
											(eval. (caddr e) a)))
			((eq (car e) 'cond)		(evcon. (cdr e) a))
			('t						(eval. (cons (assoc. (car e) a)
									(cdr e))
										a))))
		((eq (caar e) 'label)		(eval.	(cons (caddar e) (cdr e))
											(cons (list (cadar e) (car e)) a)))
		((eq (caar e) 'lambda)		(eval. (caddar e)
									(append. (pair. (cadar e) (evlis. (cdr e) a))
										a)))))
;evcon.
(defun evcon. (c a)
	(cond	((eval. (caar c) a)
			 (eval. (cadar c) a))
			('t (evcon. (cdr c) a))))
;evlis.
(defun evlis. (m a)
	(cond	((null. m) '())
			('t (cons (eval. (car m) a)
				(evlis. (cdr m) a)))))

(eval. 'x '((x a) (y b)))
(eval. '(eq 'a 'a)())
(eval. '(cons x '(b c)) '((x a) (y b)))
(eval. '(cond ((atom x) 'atom) ('t 'list)) '((x '(a b))))
(eval. '(f '(b c)) '((f (lambda (x) (cons 'a x)))))
(eval. '((label firstatom (lambda (x)
			(cond	((atom x) x)
					('t (firstatom (car x))))))
		y)
		'((y ((a b) (c d)))))
(eval. '((lambda (x y) (cons x (cdr y))) 'a '(b c d)) '())



(exit) y

