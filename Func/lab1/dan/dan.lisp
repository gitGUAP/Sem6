(print
    (list
        (CADR '(A X C))
        (CADR '(F Y))
        (CAR '(Z))
    )
)

(print
    (list
        (CADADR '((A) (B X) (C D)))
        (CAAR '((Y (Z))))
        (CAADAR '((Y (Z))))
    )
)


(print
    (list
        (CADR '(A X B Y))
        (CADDDR '(A X B Y))
        (CADR '(F Z))
    )
)

