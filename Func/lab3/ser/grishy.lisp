;Длинна ребра между вершинами A и B
(DEFUN Edge (LST A B) (
COND
((NULL LST) 99)
((AND (= (CAAR LST) A) (= (CADAR LST) B)) (CADDAR LST))
(T (Edge (CDR LST) A B)))
))

;Величина эксцентриситета по номеру вершины
(DEFUN ExByVert (LST A) (
COND
((NULL LST) 0)
((= (CAAR LST) A) (CADAR LST))
(T (ExByVert (CDR LST) A))
))

;Радиус графа - минимальный эксцентриситет
(DEFUN GraphRad ( K N LSTEXENTR &optional(minrad 99)) (
COND 
((<= N K) minrad)
(T (GraphRad (+ K 1) N LSTEXENTR (MIN minrad (ExByVert LSTEXENTR K))))
))

; Алгоритм Флойда-Уоршелла
(DEFUN DistGraph (K N LST ) (
COND 
((<= N K) LST)
(T (DistGraph (+ K 1) N (DistGraph1 0 N K LST)))
))
(DEFUN DistGraph1 (J N K LST ) (
COND 
((<= N J) LST)
(T (DistGraph1 (+ J 1) N K (DistGraph2 0 N K J LST)))
))
(DEFUN DistGraph2 (I N K J LST ) (
COND 
((<= N I) LST)
(T (DistGraph2 (+ I 1) N K J (CONS (LIST I J (MIN (Edge LST I J) (+ (Edge LST I K) (Edge LST K J)))) LST)))
))

; Нахождение эксцентриситетов вершин
(DEFUN MakeExentr (K N LST &optional(LSTDIST '()) ) (
COND 
((<= N K) LSTDIST)
(T (MakeExentr (+ K 1) N LST (MakeExentr1 0 N K LST LSTDIST)))
))

(DEFUN MakeExentr1 (J N K LST LSTDIST ) (
COND 
((<= N J) LSTDIST)
(T (MakeExentr1 (+ J 1) N K LST (CONS (LIST K (MAX (ExByVert LSTDIST K) (Edge LST J K))) LSTDIST)))
))

;Нахождение центров графа
(DEFUN Centrs ( K N LSTEXENTR RAD &optional(LSTRES '())) (
COND 
((<= N K) LSTRES)
((= (ExByVert LSTEXENTR K) RAD) (Centrs (+ K 1) N LSTEXENTR RAD (CONS K LSTRES)))
(T (Centrs (+ K 1) N LSTEXENTR RAD LSTRES))
))

;Вызов всех функций K - начальная вершина (0), N - число вершин (5), LST - список дуг типа ((начальнаявершина конечная вершина длинадуги ) (...) (...)), вершины задаются числом
(DEFUN FindCentrs (K N LST)(
Centrs K N (MakeExentr K N (DistGraph K N LST)) (GraphRad K N (MakeExentr K N (DistGraph K N LST)))
))

;Рабочий пример, вершина 3 - центр графа
(SETQ LST1 '((0 1 1) (1 2 2) (3 1 1) (2 3 2) (3 2 3) (2 4 4) (4 3 5)))
(FindCentrs 0 5 LST1)
