Базы данных и СУБД
Перед тем как начать изучение SQL, давайте познакомимся с основными понятиями баз данных. Это поможет нам понять области применения SQL и его среду выполнения.

База данных — это набор данных, хранящиеся в структурированном виде
По сути это просто хранилище неких сведений, не более того. Сами по себе базы данных не представляли бы интереса, если бы не было систем управления базами данных.

Система управления базами данных — это совокупность языковых и программных средств, которая осуществляет доступ к данным, позволяет их создавать, менять и удалять, обеспечивает безопасность данных и т.д.
Если говорить более простыми словами, то СУБД — это система, позволяющая создавать базы данных и манипулировать сведениями из них.

Простейшая схема работы с базой данных:

Схема работы базы данных
ru_schema_of_db_work.png

Рейтинг СУБД
На данный момент рейтинг систем управления базами данных на основании db-engines имеет следующий вид:

-Oracle - реляционная СУБД
-MySQL - реляционная СУБД
-Microsoft SQL Server - реляционная СУБД
-PostgreSQL - реляционная СУБД
-MongoDB - документоориентированная СУБД
-Redis - хранилище по типу «ключ-значение»
-IBM Db2 - реляционная СУБД
-Elasticsearch - поисковой движок
-Microsoft Access - реляционная СУБД
-SQLite - реляционная СУБД
Можно обратить внимание, что 7 из 10 самых популярных СУБД — реляционные. Вы сделали правильный выбор изучать именно их 😉.


Классификаций баз данных достаточно много, но давайте остановимся на наиболее востребованных:

-Реляционные базы данных
-Key-value базы данных
-Документоориентированные базы данных


Реляционные базы данных
Реляционными называются базы данных, в основе построения которых лежит реляционная модель.
Данные в реляционных структурах организованы в виде набора таблиц, называемых отношениями, состоящих из столбцов и строк. Каждая строка таблицы представляет собой набор связанных значений, относящихся к одному объекту или сущности. Каждая строка в таблице может быть помечена уникальным идентификатором, называемым первичным ключом, а строки из нескольких таблиц могут быть связаны с помощью внешних ключей.

Пример реляционной базы данных

ru_relation_dbms.png

Особенности реляционных БД

-Модель данных в реляционных БД определена заранее и является строго типизированной
-Данные хранятся в таблицах, состоящих из столбцов и строк
-На пересечении каждого столбца и строчки допускается только одно значение
-Каждый столбец проименован и имеет определённый тип, которому следуют значения со всех строк в данном столбце
-Столбцы располагаются в определённом порядке, который определяется при создании таблицы
-В таблице может не быть ни одной строчки, но обязательно должен быть хотя бы один столбец
-Запросы к базе данных возвращают результат в виде таблиц
-Более детальные особенности и принципы работы реляционных баз данных мы ещё рассмотрим в дальнейшем, так как именно они представляют наш особый интерес при изучении SQL.


Рейтинг реляционных БД по популярности

relation_dbms_rating.png


Key-value базы данных
Key-value базы данных – это тип баз данных, которые хранят данные как совокупность пар «ключ-значение», в которых ключ служит уникальным идентификатором.
То есть создаётся однозначное соответствие значения по ключу. Как ключи, так и значения могут представлять собой что угодно: от простых до сложных составных объектов.

Пример key-value базы данных

key_value_dbms.png


Преимущества:

-Скорость работы
-Простота модели хранения данных
-Гибкость: значения могут быть любыми, включая JSON

Недостатки:

-Плохо масштабируются по мере усложнения моделей данных
-Неэффективность при работе с группой записей

Стандартная реализация не даёт никакого представления о том, что содержит фактическое значение — когда вы получаете значение с помощью ключа, у вас нет гарантии того, что вы получаете. Это означает, что вам придётся фильтровать или обрабатывать данные, которые вам не нужны, в коде вашего приложения. Как правило, это будет менее эффективно с точки зрения производительности по сравнению с выполнением большей части этой работы в базе данных.

Отсутствие языка запросов
Что в свою очередь означает, что логика, которая обычно хранится в базе данных, теперь находится в коде вашего приложения, что может привести к сложности и усложнить поддержку кода.

Рейтинг key-value СУБД по популярности

popular_key_value_dbms.png

Документоориентированные БД:

Документоориентированные базы данных – это тип баз данных, направленный на хранение и запрос данных в виде документов, подобном JSON.

В отличие от других баз данных, документоориентированные оперируют «документами», сгруппированными по коллекциям. Документ представляет собой набор атрибутов (ключ и соответствующее ему значение). Значения могут быть как и простыми типами данных (строки, числа или даты), так и более сложными, такими как вложенные объекты, массивы и ссылки на другие документы.


Пример хранения данных:

ru_document_oriented_databases_1.png
ru_document_oriented_databases_2.png


Особенности документоориентированных БД:

В реляционных базах данных структура записей строго определена и каждая запись содержит одни и те же поля. Даже если поле не используется, оно присутствует, хоть и пустое.

В документоориентированных же БД используется другой подход: в них отсутствует схема данных, что позволяет добавлять новую информацию в некоторые записи, не требуя при этом, чтобы все остальные записи в базе данных имели одинаковую структуру.

Документы в базе данных адресуются с помощью уникального ключа, обычно это строка, которая генерируется автоматически. По нему можно, например, извлекать запись или ссылаться на другие документы.

Другой значимой особенностью документоориентированных баз данных является то, что помимо простого поиска документов по ключу, как в key-value базах данных, они предоставляют свой язык запросов, функционал, синтаксис и производительность которого отличается от одной реализации к другой.

Для примера, вот так может выглядеть запрос в наиболее популярном представителе данного типа баз данных - в MongoDB:

> db.users.find({"name": "Daniel"}).count()
> 1


Рейтинг СУБД по популярности:

ru_document_oriented_databases_rating.png


Структура реляционных баз данных

Мы кратко уже знакомились с реляционными базами данных в предыдущей статье. Но нам ведь недостаточно поверхностного понимания? Давайте заплывём за буйки и погрузимся глубже в структуру и терминологию реляционных баз данных.

Структура таблицы

В реляционных базах данных информация хранится в связанных друг с другом таблицах. Сами же таблицы состоят из:

-строк, которые называют «записи»
-столбцов, которые называют «полями» или же «атрибутами»

ru_structure_db.png

В каждой таблице каждый столбец имеет заранее определённый тип данных. Например, такими типами могу выступать:

-VARCHAR (строковый тип данных)
-INTEGER (числовой тип данных)
-DATETIME (тип данных для даты и времени) и прочие

И каждая строка таблицы должна иметь соответствующий тип для каждого столбца. СУБД не допустит попытку добавления в поле с типом DATETIME произвольной строки.

Для того, чтобы узнать типы данных атрибутов можно выполнить SQL команду DESCRIBE и указать название таблицы:


DESCRIBE FamilyMembers


Первичный ключ

Любая СУБД имеет встроенную систему целостности и непротиворечивости данных. Эта система работает на наборе правил, определённых в схеме базы данных. Первичный ключ и внешние ключи как раз являются одними из таких правил.

Чтобы избегать неоднозначности при поиске в таблицах присутствуют первичный ключ или, как его ещё называют, «ключевое поле».

Ключевое поле (первичный ключ) – это поле (или набор полей), значение которого однозначно определяет запись в таблице.

Если обратиться к нашей вышеупомянутой таблице FamilyMembers, то в ней ключевым полем является member_id. С помощью данного правила СУБД не позволит нам создать новую запись, где поле member_id будет неуникальным.

Внешний ключ

Внешний ключ – это поле (или набор полей) в одной таблице, которое ссылается на первичный ключ в другой таблице.
Таблица с внешним ключом называется дочерней таблицей, а таблица с первичным ключом называется ссылочной или родительской таблицей.

Правило внешнего ключа гарантирует, что при создании записей в дочерней таблице, значение поля, являющегося внешним ключом, есть в родительской таблице.

ru_keys.png


Если наличие первичного ключа – это обязательное требование для каждой таблицы в реляционной базе данных, то правило внешнего ключа – нет.

Если внешний ключ не определён, то всё также будет работать, но СУБД не будет проверять, что, например, при создании записи в таблице Purchase в полях buyer_id и good_id лежат значения, которые определены в соответствующих таблицах в поле id.

Вводная информация о SQL

SQL — язык структурированных запросов (SQL, Structured Query Language), который используется в качестве эффективного способа сохранения данных, поиска их частей, обновления, извлечения и удаления из базы данных.


Обращение к реляционным СУБД осуществляется именно благодаря SQL. С помощью него выполняются все основные махинации с базами данных, например:

- Извлекать данные из базы данных
- Вставлять записи в базу данных
- Обновлять записи в базе данных
- Удалять записи из базы данных
- Создавать новые базы данных
- Создавать новые таблицы в базе данных
- Создавать хранимые процедуры в базе данных
- Создавать представления в базе данных
- Устанавливать разрешения для таблиц, процедур и представлений


Диалекты SQL (расширения SQL)

Язык SQL – универсальный язык для всех реляционных систем управления базами данных, но многие СУБД вносят свои изменения в язык, применяемый в них, тем самым отступая от стандарта. Такие языки называют диалектами или расширениями языка.

Вот некоторые из них:

- T-SQL – диалект Microsoft SQL Server
- PL/SQL – диалект Oracle Database
- PL/pgSQL – диалект PostgreSQL

Какой диалект учить?

Если вы знаете, что вам нужно изучать SQL, вам следует изучить стандартный SQL. Однако, если вы уже знаете, с какой конкретной базой данных вы будете работать, вероятно, лучше всего изучить её диалект SQL и просто знать, что разные базы данных могут использовать немного отличающийся синтаксис.

В нашем курсе мы будем использовать СУБД MySQL, ибо она достаточно популярная и в тоже время в ней используется близкий к стандартному SQL, хотя и с небольшими отличиями. Подробнее об отличиях.
