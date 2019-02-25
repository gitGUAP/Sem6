;; 9 
(format t "~S~%" '((A) (B (C D) E (K L))))

;; Start
;; 9.1
(format t "9.1 ~S~%" 
    (CAR (CADADR '((A) (B (C D) E (K L))))))

;; 9.2
(format t "9.2 ~S~%" 
    (CADADR '((A) (B (C D) E (K L)))))

;; 9.3
(format t "9.3 ~S~%" 
    (CAADR (CDDADR '((A) (B (C D) E (K L))))))

;; 9.4 
(format t "9.3 ~S~%" 
    (list
        (CAAR '((A) (B (C D) E (K L))))
        (CAADR '((A) (B (C D) E (K L))))
        (CAR (CADADR '((A) (B (C D) E (K L)))))
    )
)

;; 9.5 
(format t "9.5 ~S~%" 
    (list
        (CAADR '((A) (B (C D) E (K L))))
        (CAAR '((A) (B (C D) E (K L))))
        (CAADR (CDDADR '((A) (B (C D) E (K L)))))
    )
)

;; 9.6 
(format t "9.6 ~S~%" 
    (list
        (CAR (CDDADR '((A) (B (C D) E (K L)))))
        (CADR (CDDADR '((A) (B (C D) E (K L)))))
    )
)
;; 9.7 
(format t "9.7 ~S~%" 
    (list
        (CAR '((A) (B (C D) E (K L))))
        (CADR (CDDADR '((A) (B (C D) E (K L)))))
    )
)