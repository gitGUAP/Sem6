(defun addToTail (x l)
  (reverse (cons x (reverse l))))

;; (setf foo '(1 2 3))
;; (print (addToTail 4 foo))

;; (defun splitBy (lst n k &optional r1 (nn 0) r2 (kk 0)) (
;;     (when ((null lst) (list r1 r2))
;;     (setq nextElem (car lst))   
;;     (setq otherElem (cdr lst))   
;;     (return (cond 
;;         ((< nn n) (splitBy otherElem n k (addToTail nextElem r1) (+ nn 1) r2 kk))
;;         ((< kk k) (splitBy otherElem n k r1 nn (addToTail nextElem r2) (+ kk 1)))                                                                                     
;;         (t (splitBy otherElem n k (addToTail nextElem r1) 1 r2 0))))))

(defun splitBy (lst n k &optional r1 (nn 0) r2 (kk 0))
  (cond ((null lst) (list r1 r2))
        ((< nn n) (splitBy (cdr lst) n k (addToTail (car lst) r1) (+ nn 1) r2 kk))
        ((< kk k) (splitBy (cdr lst) n k r1 nn (addToTail (car lst) r2) (+ kk 1))) 
        (t (splitBy (cdr lst) n k (addToTail (car lst) r1) 1 r2 0)))) 


(trace splitBy)
(print (splitBy '(1 2 3 4 5 6 7 8 9 10 11) 2 3))
