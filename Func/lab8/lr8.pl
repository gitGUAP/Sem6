run:-
     retractall(hotels/3),
     consult('db.txt'),
     menu.

menu:-

      repeat,
      write('Hotels'),nl,nl,
      write('1. Pokazat'),nl,
      write('2. Dobabit'),nl,
      write('3. Udalit bron'),nl,
      write('4. Save'),nl,
      write('5. Exit'),nl,
      write('Select: (1-5) '),
      read(X),
      X<7,
      process(X),
      X=6,!.

process(1):-view_hotels.
process(2):-add_hotels,!.
process(3):-remove_hotels,!.
process(4):-db_save_hotels,!.
process(5):-retractall(hotels/3),!.

view_hotels:-
                hotels(Name,Volume,Price),
                write('Imya: '), write(Name),
                write('; Gde: '), write(Volume),
                write('; Cena: '), write(Price),nl.

add_hotels:-
        write('Add new hotels:'),nl,nl,
        repeat,
        write('Imyz: '),
        read(Name),
        write('Gde: '),
        read(Volume),
        write('Cena: '),
        read(Price),
        assertz(hotels(Name,Volume,Price)).

quest:-
       write('Add more? y/n '),
       read(A),
       answer(A).

answer(_):-fail.
answer(y):-fail.
answer(n).

db_save_hotels:-
        tell('db.txt'),
        listing(hotels),
        told,
        write('File db.txt save!').

remove_hotels:-
           write('Delete hotels'),nl,nl,
           write('Name: '),
           read(Name),
           retract(hotels(Name,_,_)),
           write('hotels delete!'),nl,nl.

find_hotels:-
           findall(Volume,hotels(hotels,Volume,Price),Sp),
           min(Sp,Rezult),
           hotels(hotels,Volume,Price),
           Volume = Rezult,
           write('Imya: '), write(hotels),nl,
           write('Gde: '), write(Volume),nl,
           write('Cena: '), write(Price),nl,
           write('-------------------------------'),nl,
           fail.

min([Head|Tail],Rezult):-
                         min(Tail,Rezult),
                         Rezult < Head,!.
min([Head|_],Head).