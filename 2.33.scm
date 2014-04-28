(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (map p sequence)
	(accumulate 
		(lambda (x y) (cons (p x) y)) 
		()
		sequence)
	)
)
(map (lambda (x) (+ 1 x)) (list 57 321 88))


(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))
(length (list 0 1 2 3 4 5 6 7 8 9))

;;normal recursive version
(define (append seq1 seq2)
	(cond 	((null? seq1) seq2)
			((null? seq2) seq1)
			(else (cons (car seq1) (append (cdr seq1) seq2)))
	)
)
(append (list 0 1 2 3 4 5) (list 6 7 8 9))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))
(append (list 0 1 2 3 4 5) (list 6 7 8 9))



		

