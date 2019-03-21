# Лабораторная Работа №2. Разработка многопоточного приложения средствами POSIX в ОС Linux или Mac OS
## Цель работы
Знакомство с многопоточным программированием и методами синхронизации потоков средствами POSIX.

## Задание
1. Вычислить номер варианта задания как остаток от деления **суммы** порядкового номера студента по списку в журнале и **числа 5** на количество вариантов заданий. Если остаток равен нулю, выбрать последнее задание.  
**Nвар = (Nв_списке + 5) mod K**,  
где Nвар - искомый номер варианта, Nв_списке - порядковый номер студента по списку в журнале, K - количество вариантов заданий на данную лабораторную работу.
2. Выбрать граф запуска потоков в соответствии с вариантом задания. Вершины графа являются точками запуска/завершения потоков, дугами обозначены сами потоки, длину дуги следует интерпретировать как ориентировочное время выполнения потока.
3. Реализовать последовательно-параллельный запуск потоков в ОС Linux или Mac OS X с использованием средств POSIX для запуска и синхронизации потоков. Запрещается использовать какие-либо библиотеки и модули, решающие задачу кроссплатформенной разработки многопоточных приложений (std::thread, Qt Thread, Boost Thread и т.п.). Для этого необходимо написать код в файле `lab2.cpp`:
    1. Функция `unsigned int lab2_task_number()` должна возвращать номер варианта, полученный на шаге 1.
    2. Функция `int lab2_init()` заменяет собой функцию `main()`. В ней необходимо реализовать запуск потоков, инициализацию вспомогательных переменных (мьютексов, семафоров и т.п.). Перед выходом из функции `lab2_init()` необходимо убедиться, что все запущенные потоки завершились. Возвращаемое значение: `0` - работа функции завершилась успешно, любое другое числовое значение - при выполнении функции произошла критическая ошибка.
    3. Добавить любые другие необходимые для работы программы функции, переменные и подключаемые файлы.
    4. Писать функцию `main()` не нужно. В проекте уже имеется готовая функция `main()`, изменять ее нельзя. Она выполняет единственное действие: вызывает функцию `lab2_init()`.
    5. Не следует изменять какие-либо файлы, кроме `lab2.cpp`. Также не следует создавать новые файлы и писать в них код, поскольку код из этих файлов не будет использоваться во время тестирования.
4. Самостоятельно выделить на графе две группы с выполняющимися параллельно потоками. Первая группа не синхронизирована, параллельное выполнение входящих в группу потоков происходит за счет использования искусственной задержки (см. [примеры](examples/README.md) [1](examples/README.md#Организация-параллельного-выполнения-потоков-без-использования-средств-синхронизации) и [2](examples/README.md#Использование-мьютекса-для-работы-с-общим-ресурсом)). Величина задержки не должна быть как можно меньше. При выполнении операций ввода-вывода перед входом в критическую секцию потоки должны захватывать мьютекс. Вторая группа синхронизирована семафорами: входящий в групу поток передает управление другому потоку после каждой итерации (см. [пример 3](examples/README.md#Использование-семафоров-для-синхронизации-потоков)).
5. Последовательное выполнение потоков должно обеспечиваться за счет использования семафоров. Все потоки должны запускаться одновременно из функции `lab2_init()`, без задержек, один за другим. Использовать функцию `pthread_join()` разрешается только в функции `lab2_init()` для ожидания завершения работы всех запущенных потоков.


В процессе своей работы каждый поток выводит свою букву в консоль. Оценка правильности выполнения лабораторной работы осуществляется следующим образом. Если потоки **a** и **b** согласно графу должны выполняться параллельно, то в консоли должна присутствовать последовательность вида **abababab** (или схожая, например, **aabbba**); если задачи выполняются последовательно, то в консоли присутствует последовательность вида **aaaaabbbbbb**, причем после появления первой буквы **b**, буква **a** больше не должна появиться в консоли. Количество букв, выводимых каждым потоком в консоль, должно быть пропорционально длине дуги, соответствующей данному потоку на графе. При этом количество символов, выводимых в консоль каждым из потоков, должно быть не меньше чем 3Q и не больше чем 5Q, где Q - количество интервалов на графе, в течении которых выполняется поток.

## Пример работы с графом потока
Рассмотрим граф запуска потоков, приведенный на рисунке ниже.
![Пример графа запуска потоков](thread_graphs/example.png "Пример графа запуска потоков")

Программа, реализующая указанную на графе последовательность запуска потоков, должна запустить 5 потоков: *a*, *b*, *c*, *d* и *e*. Работу программы можно разбить на три временных интервала:
1. С момента времени T<sub>0</sub> до T<sub>1</sub> работает только поток *a*.
2. С T<sub>1</sub> до T<sub>2</sub> параллельно работают потоки *b*, *c* и *d*.
3. С T<sub>2</sub> до T<sub>3</sub> параллельно работают потоки *d* и *e*.

## Сборка и тестирование
Скомпилировать программу из консоли без использования линковщика можно следующим образом. Сначала необходимо перейти в директорию, в которой находятся исходные файлы lab2.h, lab2.cpp и main.cpp. Далее все команды будут приводиться относительно этой директории.

Компиляция программы в файл `a.out` в текущей папке: 
```
g++ lab2.cpp main.cpp -lpthread
```
При использовании старой версии компилятора GCC может потребоваться дополнительно указать ключ `-std=c++11`. В этом случае компилятор выведет соответствующее сообщение в консоль.

Запуск скомпилированной программы: `./a.out`. При желании можно указать ключ `-o` при компиляции, в этом случае можно будет задать более осмысленное имя итогового файла с программой, нежели `a.out`. Например,
```
g++ lab2.cpp main.cpp -lpthread -o lab2
./lab2
```

### Тестирование
Для запуска тестов на локальной машине предварительно потребуется собрать библиотеку [`gtest`](https://github.com/google/googletest). Для этого, перед первой компиляцией тестов, необходимо выполнить следующую последовательность команд:
```
cd test/gtest
GTEST_DIR=$(pwd)
g++ -isystem ${GTEST_DIR}/include -I${GTEST_DIR} -pthread -c ${GTEST_DIR}/src/gtest-all.cc 
ar -rv libgtest.a gtest-all.o
```
В консоли должен появиться текст
```
ar: creating libgtest.a
a - gtest-all.o
```
Также можно убедиться с помощью команды `ls -l`, что в текущей папке появился файл `libgtest.a` и его размер больше нуля байт. Если все прошло успешно, в дальнейшем вызывать эти команды более не потребуется.

Далее необходимо вернуться в директорию `test`, расположенную в корневой директории репозитория. Для компиляции тестов необходимо выполнить команду 
```
g++ ../lab2.cpp tests.cpp -lpthread -lgtest -o runTests -I gtest/include -L gtest
``` 
При необходимости следует добавить ключ  `-std=c++11`. Запустить тесты можно командой `./runTests`. Если не все тесты завершились успешно, необходимо внести изменения в файл `lab2.cpp`, добившись правильного выполнения задания, затем повторно скомпиировать тесты командой `g++ ../lab2.cpp tests.cpp -lpthread -lgtest -o runTests -I gtest/include -L gtest`, после чего вновь запустить процесс тестирования. 

Рекомендуется локально запускать тесты несколько раз даже в случае их успешного выполнения, поскольку последовательность выполнения потоков может отличаться от запуска к запуску программы и ошибка в решении задачи синхронизации потоков может проявляться не всегда. Если тесты пройдены успешно, можно выполнить команды `git add lab2.cpp`, `git commit` и `git push`, после чего убедиться, что тесты также успешно пройдены и в репозитории.

## Содержание отчета
- Титульный лист 
- Цель работы
- Задание на лабораторную работу
- Граф запуска потоков
- Результат выполнения работы
- Исходный код программы с комментариями
- Выводы

## Варианты графов запуска потоков

| Номер варианта  | Граф запуска потоков |
| --- | --- |
| 1   | ![Граф запуска потоков №1](thread_graphs/1.png "Граф запуска потоков №1")  |
| 2   | ![Граф запуска потоков №2](thread_graphs/2.png "Граф запуска потоков №2")  |
| 3   | ![Граф запуска потоков №3](thread_graphs/3.png "Граф запуска потоков №3")  |
| 4   | ![Граф запуска потоков №4](thread_graphs/4.png "Граф запуска потоков №4")  |
| 5   | ![Граф запуска потоков №5](thread_graphs/5.png "Граф запуска потоков №5")  |
| 6   | ![Граф запуска потоков №6](thread_graphs/6.png "Граф запуска потоков №6")  |
| 7   | ![Граф запуска потоков №7](thread_graphs/7.png "Граф запуска потоков №7")  |
| 8   | ![Граф запуска потоков №8](thread_graphs/8.png "Граф запуска потоков №8")  |
| 9   | ![Граф запуска потоков №9](thread_graphs/9.png "Граф запуска потоков №9")  |
| 10  | ![Граф запуска потоков №10](thread_graphs/10.png "Граф запуска потоков №10")  |
| 11  | ![Граф запуска потоков №11](thread_graphs/11.png "Граф запуска потоков №11")  |
| 12  | ![Граф запуска потоков №12](thread_graphs/12.png "Граф запуска потоков №12")  |
| 13  | ![Граф запуска потоков №13](thread_graphs/13.png "Граф запуска потоков №13")  |
| 14  | ![Граф запуска потоков №14](thread_graphs/14.png "Граф запуска потоков №14")  |
| 15  | ![Граф запуска потоков №15](thread_graphs/15.png "Граф запуска потоков №15")  |
| 16  | ![Граф запуска потоков №16](thread_graphs/16.png "Граф запуска потоков №16")  |
| 17  | ![Граф запуска потоков №17](thread_graphs/17.png "Граф запуска потоков №17")  |
| 18  | ![Граф запуска потоков №18](thread_graphs/18.png "Граф запуска потоков №18")  |
| 19  | ![Граф запуска потоков №19](thread_graphs/19.png "Граф запуска потоков №19")  |
| 20  | ![Граф запуска потоков №20](thread_graphs/20.png "Граф запуска потоков №20")  |

## Вопросы
Электронный адрес для связи: m.polyak [собачка] guap [точка] ru