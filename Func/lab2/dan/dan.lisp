;; 14. Разработать функцию, преобразующую исходный список, в список «луковицу».
;; Например:
;; Вход: (3 2 1 2 3).
;; Выход: (3 (2 (1) 2) 3). 


(defun onion (L)
 (cond
  ((null L) nil)
  ((null (cdr L)) L)
  (T
   (cons
    (car L)
    (cons
     (onion (cdr (butlast L)))
     (last L))))))

(trace onion)
(print (onion '(3 2 1 2 3)))
(print '(3 2 1 2 3))
