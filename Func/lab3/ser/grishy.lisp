;; 9. Нахождение центральной вершины орграфа
;; Дан некоторый связный ориентированный граф. Необходимо найти в нём
;; центральную вершину (наиболее равноудалённую ото всех остальных).
;; Наиболее равноудалённая вершина может быть получена как вершина, среднее
;; расстояние от которой до других вершин наиболее близко к среднему значению
;; этой величины для всех вершин графа. Если таких вершин несколько, вывести
;; их все

(defun F (Net)
 ((lambda (enum counter)
   ((lambda (averages)
     ((lambda (mid)
       ((lambda (deviations)
         (EXTRACT_MIN (apply 'min deviations) deviations enum))
        (mapcar
        #'(lambda (dist)
          (abs (- dist mid)))
         averages)))
      (/ (apply '+ averages) counter)))
    (mapcar
    #'(lambda (node)
      (/
       (apply '+
        (mapcar
        #'(lambda (other)
          (DIJKSTRA Net node other))
         (remove node enum :test 'EQUAL)))
       (1- counter)))
     enum)))
  (mapcar 'car Net)
  (length Net)))

(defun EXTRACT_MIN (minimal deviations enum)
 (if deviations
  ((lambda (test result)
    (if test (cons (car enum) result) result))
   (equal (car deviations) minimal)
   (EXTRACT_MIN minimal (cdr deviations) (cdr enum)))))

(defun DIJKSTRA (Net Init Term
 &optional (Tmp nil) (Fix (list (cons Init 0))))
 ((lambda (fix_label fix_value)
   (if (equal fix_label Term) fix_value
    (apply 
     #'(lambda (newTmp newFix)
      (DIJKSTRA Net Init Term newTmp newFix))
     (TRANSFER_MIN
      (UPDATE_Tmp Tmp Fix (cdr (assoc fix_label Net)))
      Fix))))
  (caar Fix)
  (cdar Fix)))

(defun UPDATE_Tmp (Tmp Fix Links)
 (if Links
  ((lambda (link_label link_value)
    (UPDATE_Tmp
     (if (assoc link_label Fix :test 'EQUAL) Tmp
      ((lambda (link mark)
        (if link
         (subst
          (cons link_label (min mark (cdr link)))
          link
          Tmp
          :test 'EQUAL)
         (cons (cons link_label mark) Tmp)))
       (assoc link_label Tmp :test 'EQUAL)
       (+ link_value (cdar Fix))))
     Fix
     (cdr Links)))
   (caar Links)
   (cdar Links))
  Tmp))

(defun TRANSFER_MIN (Tmp Fix)
 (if Tmp
  (if (cdr Tmp)
   (apply
    #'(lambda (elem newTmp newFix)
     (if (< (cdr elem) (cdar newFix))
      (list
       (cons (car newFix) newTmp)
       (cons elem (cdr newFix)))
      (list
       (cons elem newTmp)
       newFix)))
    (cons (car Tmp) (TRANSFER_MIN (cdr Tmp) Fix)))
   (list
    (cdr Tmp)
    (cons (car Tmp) Fix)))
  (list Tmp Fix)))


(setq Net
'((1 (2 . 4)(3 . 7))
(2 (1 . 4)(3 . 3)(6 . 1))
(3 (1 . 7)(2 . 3)(4 . 2)(5 . 5))
(4 (3 . 2)(5 . 1)(6 . 7))
(5 (3 . 5)(4 . 1)(6 . 3))
(6 (2 . 1)(4 . 7)(5 . 3))))

(print (F Net))
