Многотабличные запросы, JOIN

Многотабличные запросы

В предыдущих статьях описывалась работа только с одной таблицей базы данных. В реальности же очень часто
приходится делать выборку из нескольких таблиц, каким-то образом объединяя их. В данной статье вы узнаете
основные способы соединения таблиц.

Например, если мы хотим получить информацию о тратах на покупки, мы можем её получить следующим образом:
SELECT family_member, amount * unit_price AS price FROM Payments;

family_member	price
1	            2000
2	            2100
3	            100
4	            350
4	            300


В поле family_member полученной выборки отображаются идентификаторы записей из таблицы FamilyMembers,
но для нас они мало что значат.

Вместо этих идентификаторов было бы гораздо нагляднее выводить имена тех, кто покупал
(поле member_name из таблицы FamilyMember). Ровно для этого и существует объединение таблиц и оператор JOIN.


Общая структура многотабличного запроса

SELECT поля_таблиц
FROM таблица_1
[INNER] | [[LEFT | RIGHT | FULL][OUTER]] JOIN таблица_2
    ON условие_соединения
[INNER] | [[LEFT | RIGHT | FULL][OUTER]] JOIN таблица_n
    ON условие_соединения]


Как можно увидеть по структуре, соединение бывает:

- внутренним INNER (по умолчанию)
- внешним OUTER, при этом внешнее соединение делится на левое LEFT, правое RIGHT и полное FULL


С более подробными деталями, чем отличается внутреннее соединение от внешнего и как они работают,
мы познакомимся в следующих статьях.

Пока нам достаточно лишь знать, что для вышеописанного примера с запросом на покупки нам понадобится именно
запрос с внутренним соединением, который будет выглядеть следующим образом:

SELECT family_member, member_name, amount * unit_price AS price FROM Payments
INNER JOIN FamilyMembers ON Payments.family_member = FamilyMembers.member_id;

family_member	    member_name	        price
1	                Headley Quincey	    2000
2	                Flavia Quincey	    2100
3	                Andie Quincey	    100
4	                Lela Quincey	    350
4	                Lela Quincey	    300


В данном запросе мы сопоставляем записи из таблицы Payments и записи из таблицы FamilyMembers.

Чтобы сопоставление работало, мы указываем как именно записи из двух разных таблиц должны находить друг друга.
Это условие указывается после ON:
ON Payments.family_member = FamilyMembers.member_id;

В нашем случае поле family_member указывает на идентификатор в таблице FamilyMembers и таким образом помогает
однозначному сопоставлению.

В большинстве случаев условием соединения является равенство столбцов таблиц (таблица_1.поле = таблица_2.поле),
однако точно так же можно использовать и другие операторы сравнения.


Внутреннее соединение INNER JOIN

В предыдущем уроке мы рассмотрели общую структуру многотабличного запроса:

SELECT поля_таблиц
FROM таблица_1
[INNER] | [[LEFT | RIGHT | FULL][OUTER]] JOIN таблица_2
    ON условие_соединения
[INNER] | [[LEFT | RIGHT | FULL][OUTER]] JOIN таблица_n
    ON условие_соединения]


Говоря о многотабличном запросе со внутренним соединением общая структура выглядит так:

SELECT поля_таблиц
FROM таблица_1
[INNER] JOIN таблица_2
    ON условие_соединения
[INNER] JOIN таблица_n
    ON условие_соединения]


Например, запрос может выглядеть следующим образом:

SELECT family_member, member_name FROM Payments
INNER JOIN FamilyMembers
    ON Payments.family_member = FamilyMembers.member_id


Так как, по умолчанию, если не указаны какие-либо параметры, JOIN выполняется как INNER JOIN,
то при внутреннем соединении INNER является опциональным.


Внутреннее соединение — соединение, при котором находятся пары записей из двух таблиц,
удовлетворяющие условию соединения, тем самым образуя новую таблицу, содержащую поля из первой и второй исходных
таблиц.


Использование WHERE для соединения таблиц

Для внутреннего соединения таблиц также можно использовать оператор WHERE. Например, вышеприведённый запрос,
написанный с помощью INNER JOIN, будет выглядеть так:

SELECT family_member, member_name FROM Payments, FamilyMembers
    WHERE Payments.family_member = FamilyMembers.member_id



1. Объедините таблицы Class и Student_in_class с помощью внутреннего соединения по полям Class.id и
Student_in_class.class. Выведите название класса (поле Class.name) и идентификатор
ученика (поле Student_in_class.student):

SELECT class.name, student
FROM Student_in_class
JOIN Class ON Student_in_class.class = Class.id;

2. Дополните запрос из предыдущего задания, добавив ещё одно внутреннее соединение с таблицей Student.
Объедините по полям Student_in_class.student и Student.id и вместо идентификатора ученика выведите его имя
(поле first_name):

SELECT class.name, student.first_name
FROM Student_in_class
JOIN Class ON Student_in_class.class = Class.id
JOIN Student ON Student_in_class.student = Student.id;


3. Выведите названия продуктов, которые покупал член семьи со статусом "son".
Для получения выборки вам нужно объединить таблицу Payments с таблицей FamilyMembers по полям family_member и
member_id, а также с таблицей Goods по полям good и good_id:

SELECT good_name
FROM Payments
JOIN Goods ON Payments.good = Goods.good_id
JOIN FamilyMembers ON Payments.family_member = FamilyMembers.member_id
WHERE FamilyMembers.status = "son";


4. Выведите идентификатор (поле room_id) и среднюю оценку комнаты (поле rating, для вывода используйте псевдоним
avg_score), составленную на основании отзывов из таблицы Reviews.
Данная таблица связана с Reservations (таблица, где вы можете взять идентификатор комнаты)
по полям reservation_id и Reservations.id:

SELECT re.room_id AS room_id, AVG(rv.rating) AS avg_score
FROM Reviews rv
JOIN Reservations re ON rv.reservation_id = re.id
GROUP BY re.room_id;



Внешнее соединение OUTER JOIN

Внешнее соединение может быть трёх типов: левое (LEFT), правое (RIGHT) и полное (FULL).
По умолчанию оно является полным.

Главным отличием внешнего соединения от внутреннего является то, что оно обязательно возвращает все
строки одной (LEFT, RIGHT) или двух таблиц (FULL).

Внешнее левое соединение (LEFT OUTER JOIN)
Соединение, которое возвращает все значения из левой таблицы, соединённые с соответствующими значениями из правой
таблицы, если они удовлетворяют условию соединения, или заменяет их на NULL в обратном случае.

Для примера получим из базы данных расписание звонков, объединённых с соответствующими занятиями в расписании занятий.

Данные в таблице Timepair (расписание звонков):

id	start_pair	end_pair
1	08:30:00	09:15:00
2	09:20:00	10:05:00
3	10:15:00	11:00:00
4	11:05:00	11:50:00
5	12:50:00	13:35:00
6	13:40:00	14:25:00


Данные в таблице Schedule (расписание занятий):

id	        date	            class	number_pair     teacher     subject     classroom
1	2019-09-01T00:00:00.000Z	9	        1	        11	        1	        47
2	2019-09-01T00:00:00.000Z	9	        2	        8	        2	        13
3	2019-09-01T00:00:00.000Z	9	        3	        4	        3	        13
4	2019-09-02T00:00:00.000Z	9	        1	        4	        3	        13
5	2019-09-02T00:00:00.000Z	9	        2	        2	        4	        34
6	2019-09-02T00:00:00.000Z	9	        3	        6	        5	        35



SELECT Timepair.id 'timepair.id', start_pair, end_pair,
    Schedule.id 'schedule.id', date, class, number_pair, teacher, subject, classroom
FROM Timepair
    LEFT JOIN Schedule ON Schedule.number_pair = Timepair.id;

В выборку попали все строки из левой таблицы, дополненные данными о занятиях. Примечательно, что в конце таблицы
есть строки с полями, заполненными NULL. Это те строки, для которых не нашлось соответствующих занятий,
однако они присутствуют в левой таблице, поэтому тоже были выведены.



Внешнее правое соединение (RIGHT OUTER JOIN)

Соединение, которое возвращает все значения из правой таблицы, соединённые с соответствующими значениями из
левой таблицы, если они удовлетворяют условию соединения, или заменяет их на NULL в обратном случае.



Внешнее полное соединение (FULL OUTER JOIN)
Соединение, которое выполняет внутреннее соединение записей и дополняет их левым внешним соединением и правым
внешним соединением.

Алгоритм работы полного соединения:

- Формируется таблица на основе внутреннего соединения (INNER JOIN)
- В таблицу добавляются значения не вошедшие в результат формирования из левой таблицы (LEFT OUTER JOIN)
- В таблицу добавляются значения не вошедшие в результат формирования из правой таблицы (RIGHT OUTER JOIN)



Соединение FULL JOIN реализовано не во всех СУБД. Например, в MySQL оно отсутствует, однако его можно очень
просто эмулировать:

SELECT *
FROM левая_таблица
LEFT JOIN правая_таблица
   ON правая_таблица.ключ = левая_таблица.ключ

UNION ALL

SELECT *
FROM левая_таблица
RIGHT JOIN правая_таблица
ON правая_таблица.ключ = левая_таблица.ключ
 WHERE левая_таблица.ключ IS NULL




Базовые запросы для разных вариантов объединения таблиц
Схема	                    Запрос с JOIN

LEFT JOIN
                            Получение всех данных из левой таблицы, соединённых с
                            соответствующими данными из правой:

                            SELECT поля_таблиц
                            FROM левая_таблица LEFT JOIN правая_таблица
                                ON правая_таблица.ключ = левая_таблица.ключ


RIGHT JOIN

                            Получение всех данных из правой таблицы, соединённых с
                            соответствующими данными из левой:

                            SELECT поля_таблиц
                            FROM левая_таблица RIGHT JOIN правая_таблица
                                ON правая_таблица.ключ = левая_таблица.ключ


LEFT JOIN
                            Получение данных, относящихся только к левой таблице:

                            SELECT поля_таблиц
                            FROM левая_таблица LEFT JOIN правая_таблица
                                ON правая_таблица.ключ = левая_таблица.ключ
                            WHERE правая_таблица.ключ IS NULL


RIGHT JOIN

                            Получение данных, относящихся только к правой таблице:

                            SELECT поля_таблиц
                            FROM левая_таблица RIGHT JOIN правая_таблица
                                ON правая_таблица.ключ = левая_таблица.ключ
                            WHERE левая_таблица.ключ IS NULL


INNER JOIN

                            Получение данных, относящихся как к левой, так и к правой таблице:

                            SELECT поля_таблиц
                            FROM левая_таблица INNER JOIN правая_таблица
                                ON правая_таблица.ключ = левая_таблица.ключ


FULL JOIN

                            Получение всех данных, относящихся к левой и правой таблицам,
                            а также их внутреннему соединению:

                            SELECT поля_таблиц
                            FROM левая_таблица
                                FULL OUTER JOIN правая_таблица
                                ON правая_таблица.ключ = левая_таблица.ключ


FULL JOIN

                            Получение данных, не относящихся к левой и правой таблицам
                            одновременно (обратное INNER JOIN):

                            SELECT поля_таблиц
                            FROM левая_таблица
                                FULL OUTER JOIN правая_таблица
                                ON правая_таблица.ключ = левая_таблица.ключ
                            WHERE левая_таблица.ключ IS NULL
                                OR правая_таблица.ключ IS NULL




1. Выведите имена first_name и фамилии last_name всех учителей из таблицы Teacher, а также количество занятий,
в которых они назначены преподавателями.
Для вывода количества занятий используйте псевдоним amount_classes:

SELECT Teacher.first_name, Teacher.last_name, COUNT(Schedule.class) as amount_classes
FROM Schedule
JOIN Teacher ON Teacher.id = Schedule.teacher
JOIN Class ON Class.id = Schedule.class
GROUP BY Teacher.id



Ограничение выборки, оператор LIMIT

Оператор LIMIT позволяет извлечь определённый диапазон записей из одной или нескольких таблиц.

Общая структура запроса с оператором LIMIT

SELECT поля_выборки
FROM список_таблиц
LIMIT [количество_пропущенных_записей,] количество_записей_для_вывода;


Если не указать количество пропущенных записей, то их отсчёт будет вестись с начала таблицы.

Оператор LIMIT реализован не во всех СУБД, например, в MSSQL для вывода записей с начала таблицы используется
оператор TOP, а для тех случаев, когда необходимо сделать отступ от начала таблицы, предназначена конструкция
OFFSET FETCH.


Пример использования
Возьмём таблицу Company:

id	name
1	Don_avia
2	Aeroflot
3	Dale_avia
4	air_France
5	British_AW

Для того, чтобы вывести строки с 3 по 5, нужно использовать такой запрос:

SELECT * FROM Company LIMIT 2, 3;

Или, что то же самое:

SELECT * FROM Company LIMIT 3 OFFSET 2;

В результате запроса вернётся следующая выборка:

id	name
3	Dale_avia
4	air_France
5	British_AW

В данном запросе происходит пропуск первых двух строк таблицы (1, 2), после чего выводятся следующие
три записи (3, 4, 5).



1.Отсортируйте список компаний (таблица Company) по их названию в алфавитном порядке и выведите первые две записи:

SELECT *
From Company
ORDER BY name
LIMIT 2


2. Выведите начало (поле start_pair) и окончание (поле end_pair) второго и третьего занятия из таблицы Timepair.

SELECT start_pair, end_pair
FROM Timepair
JOIN Schedule ON Schedule.number_pair = Timepair.id
LIMIT 1,2;




Подзапросы
Подзапросы являются одним из самых мощных инструментов 💪 в SQL, который можно использовать в любых видах запросов.
В ближайших уроках мы познакомимся с основными типами подзапросов и рассмотрим примеры как их можно использовать.

Подзапрос — это запрос, использующийся в другом SQL запросе. Подзапрос всегда заключён в круглые
скобки и обычно выполняется перед основным запросом.

Как и любой другой SQL запрос, подзапрос возвращает результирующий набор, который может быть одним из следующих:

- одна строка и один столбец;
- нескольких строк с одним столбцом;
- нескольких строк с несколькими столбцами.

В зависимости от типа результирующего набора подзапроса определяются операторы, которые могут использоваться
в основном запросе.


Пример
Получим список всех бронирований самого дорогого на данный момент жилого помещения:

SELECT * FROM Reservations
    WHERE Reservations.room_id = (
        SELECT id FROM Rooms ORDER BY price DESC LIMIT 1;
    )


В данном случае запрос на получение самого дорого жилого помещения выполняется в качестве подзапроса,
а затем результат результирующего набора применяется в основном запросе.

SELECT id FROM Rooms ORDER BY price DESC LIMIT 1;


Подзапрос с одной строкой с одним столбцом
В этом уроке давайте более детально остановимся на подзапросе, возвращающем одну строку и один столбец.
Данный тип подзапросов также известен как скалярный подзапрос.

Он может использоваться в различных частях основного SQL запроса, но чаще всего он используется в условиях
ограничений выборки с помощью операторов сравнения (=, <>, >, <).


Примеры
Следующий простейший запрос демонстрирует вывод единственного значения (названия компании).
В таком виде он не имеет большого смысла, однако ваши запросы могут быть намного сложнее.

SELECT (SELECT name FROM company LIMIT 1) AS company_name;


Таким же образом можно использовать скалярные подзапросы для фильтрации строк с помощью WHERE,
используя операторы сравнения.

SELECT * FROM FamilyMembers
    WHERE birthday = (SELECT MAX(birthday) FROM FamilyMembers);


С помощью данного запроса возможно получить самого младшего члена семьи.
Подзапрос в данном случае необходим для получения максимальной даты рождения, которая затем используется
в основном запросе для фильтрации строк.


Важность соответствия используемого оператора и результата подзапроса
При использовании результата подзапроса с операторами сравнения, как в нашем примере, важно, чтобы подзапрос возвращал именно скалярное значение (1 строка и 1 колонка).

Если бы данный подзапрос вернул несколько значений, то СУБД бы вернула ошибку, сообщающую, что ожидалось, что подзапрос вернёт лишь 1 запись: «ER_SUBQUERY_NO_1_ROW: Subquery returns more than 1 row».

Поэтому стоит быть осторожным при написании подзапросов и представлять, какой результат вернёт подзапрос, и какие операторы мы можем использовать вместе с результирующим набором.


Выведите всю информацию о пользователе из таблицы Users, кто является владельцем самого дорого жилья (таблица Rooms).

SELECT u.id, u.name, u.email, u.email_verified_at, u.password, u.phone_number
FROM Users u
JOIN Rooms ON u.id = Rooms.owner_id
WHERE price = (SELECT MAX(price) FROM Rooms);



Подзапросы с несколькими строками и одним столбцом
Если подзапрос возвращает более одной строки, его нельзя просто использовать с операторами сравнения,
как это можно было делать со скалярными подзапросами.

Однако c подзапросами, возвращающими несколько строк и один столбец, можно использовать 3 дополнительных оператора.


Подзапрос и оператор ALL
С помощью оператора ALL мы можем сравнивать отдельное значение с каждым значением в наборе, полученным подзапросом.
При этом данное условие вернёт TRUE, только если все сравнения отдельного значения со значениями в наборе вернут TRUE.

Например, нижеприведённый синтетический запрос проверяет для всех ли жилых помещений выполняется условие,
что оно дешевле чем 200.

SELECT 200 > ALL(SELECT price FROM Rooms);


Или же, более практический пример: нам необходимо найти имена всех владельцев жилья, которые сами при этом никогда
не снимали жилье. Чтобы получить данный список, мы можем действовать следующим образом:

- Получить список имён всех владельцев жилья:

SELECT DISTINCT name FROM Users INNER JOIN Rooms
ON Users.id = Rooms.owner_id

- Получить список идентификаторов всех пользователей, снимавших жилье:

SELECT DISTINCT user_id FROM Reservations

- Отфильтровать первый список всех владельцев по условию, что идентификатор владельца жилья не равен ни одному
из идентификаторов пользователей, когда-либо снимавших жилье:

SELECT DISTINCT name FROM Users INNER JOIN Rooms
    ON Users.id = Rooms.owner_id
    WHERE Users.id <> ALL (
        SELECT DISTINCT user_id FROM Reservations
    );



Подзапрос и оператор IN
Оператор IN проверяет входит ли конкретное значение в набор значений. В качестве такого набора как раз может
использовать подзапрос, возвращающий несколько строк с одним столбцом.

Например, если нам необходимо получить всю информацию о владельцах жилья стоимостью больше 150 условных единиц,
то это можно сделать следующим образом:

SELECT * FROM Users WHERE id IN (
    SELECT DISTINCT owner_id FROM Rooms WHERE price >= 150
)



Подзапрос и оператор ANY
Условное выражение с ANY имеет схожие поведение, но оно возвращает TRUE, если хотя бы одно сравнение отдельного
значения со значением в наборе вернёт TRUE.

Давайте с помощью его напишем такой же запрос, что мы делали с оператором IN: найдёт пользователей,
которые владеют хотя бы 1 жилым помещением стоимостью более 150.

SELECT * FROM Users WHERE id = ANY (
    SELECT DISTINCT owner_id FROM Rooms WHERE price >= 150
)



1. Выведите названия товаров из таблицы Goods (поле good_name), которые ещё ни разу не покупались ни одним из членов
семьи (таблица Payments):

SELECT DISTINCT good_name FROM Goods
WHERE Goods.good_id <> ALL (SELECT DISTINCT good FROM Payments)
