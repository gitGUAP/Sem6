man("Shandor"). /* Шандор */
man("Gabor"). /* Габор */
man("Laslo"). /* Ласло */
man("Zoltan"). /* Золтан */

drink("Wine"). /* стакан вина */
drink("Beer"). /* кружка пива */
drink("Juice"). /* вишневый сок */
drink("Coca-Cola"). /* бутылка кока-колы */

food("Sandwich"). /* бутерброд */
food("Cakes"). /* тарелочка с четырьмя пирожными */
food("Pies"). /* тарелочка с тремя пирожками с мясом */
food("IceCream"). /* мороженое */

check_mans(Order) :- 
    nth1(1, Order, [W,_,_]), man(W),
    nth1(2, Order, [X,_,_]), man(X),
    nth1(3, Order, [Y,_,_]), man(Y),
    nth1(4, Order, [Z,_,_]), man(Z),
    \+ W = X, \+ X = Y, \+ Y = Z, \+ W = Y, \+ W = Z, \+ X = Z.

check_drink(Order) :- 
    nth1(1, Order, [_,W,_]), drink(W),
    nth1(2, Order, [_,X,_]), drink(X),
    nth1(3, Order, [_,Y,_]), drink(Y),
    nth1(4, Order, [_,Z,_]), drink(Z),
    \+ W = X, \+ X = Y, \+ Y = Z, \+ W = Y, \+ W = Z, \+ X = Z.

check_food(Order) :- 
    nth1(1, Order, [_,_,W]), food(W),
    nth1(2, Order, [_,_,X]), food(X),
    nth1(3, Order, [_,_,Y]), food(Y),
    nth1(4, Order, [_,_,Z]), food(Z),
    \+ W = X, \+ X = Y, \+ Y = Z, \+ W = Y, \+ W = Z, \+ X = Z.

/* 1.   — Прошу иметь в виду, что я не употребляю алкогольных напитков, — заметил Золтан. */
expr1(Order) :- \+ member(["Zoltan","Beer",_],Order), \+ member(["Zoltan","Wine",_],Order).

/* 2.   — Тогда, должно быть, пирожки с мясом не ваши, ведь они лучше идут с пивом или с вином.
—   А я и не думал заказывать пирожки, — ответил Золтан, обращаясь к своим друзьям, и 
преспокойно съел пирожок. */
expr2(Order) :- \+ member(["Zoltan",_,"Pies"],Order), \+ member([_,"Beer","Pies"],Order), \+ member([_,"Wine","Pies"],Order).

/* 3.   — Не теплое ли пиво? — осведомился один из сидевших за столиком у другого.
— В самый раз, не горячей твоего мороженого,— опетил тот. */


/* 4.   — Я не люблю сладкого, — заявил Ласло. */
expr4(Order) :- \+ member(["Laslo","Coca-Cola",_],Order), \+ member(["Laslo",_,"Cakes"],Order), \+ member(["Laslo",_,"IceCream"],Order).

/* 5.   — К сожалению, я забыл заказать пирожки, но вишневый сок — мой, — сказал один из друзей. */
expr5(Order) :- \+ member([_,"Juice","Pies"],Order).

/* 6.   — Я не заказывал ничего мучного, — предупредил официанта Золтан, отодвигая от себя 
поставленную перед ним кружку пива. */
expr6(Order) :- \+ member(["Shandor",_,"Cakes"],Order), \+ member(["Shandor",_,"Pies"],Order), \+ member(["Shandor","Wine",_],Order).

find_order:-
    Order = [_,_,_,_],
    check_mans(Order),
    check_drink(Order),
    check_food(Order),
    expr1(Order),
    expr2(Order),
    expr4(Order),
    expr5(Order),
    expr6(Order),
    print(Order).
