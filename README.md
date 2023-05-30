# Anya Paiu CS31
Library app


# HTTP Verbs
| HTTP METHOD | URL             | Payload | Description                  |
|-------------|-----------------|---------|------------------------------|
GET |/genres |{} |index genres
POST|/genres |{...} |create genre
GET |/genres/:id |{} |show genre
PATCH/PUT |/genres/:id |{...} |update genre
DELETE |/genres/:id|{} |destroy genre
GET |/users |{} |index users
POST|/users |{...} |create user
GET |/users/:id |{} |show user
PATCH/PUT |/users/:id |{...} |update user
DELETE |/users/:id |{} |destroy user
GET |/authors |{} |index authors
POST|/authors |{...} |create author
GET |/authors/:id|{} |show author
PATCH/PUT |/authors/:id|{...} |update author
DELETE |/authors/:id|{} |destroy author
GET |/reader_cards |{} |index reader cards
POST|/reader_cards |{...} |create reader card
GET |/reader_cards/:id|{} |show reader card
PATCH/PUT |/reader_cards/:id|{...}|update reader card
DELETE |/reader_cards/:id|{} |destroy reader card
GET |/libraries |{} |index libraries
POST|/libraries |{...} |create library
GET |/libraries/:id |{} |show library
PATCH/PUT |/libraries/:id|{...} |update library
DELETE |/libraries/:id |{} |destroy library
GET |/books |{} |index books
POST|/books |{...} |create book
GET |/books/:id |{} |show book
PATCH/PUT |/books/:id |{...} |update book
DELETE |/books/:id |{} |destroy book
GET |/home |{} |home page

# ERD diagram

# Labs
- [ ] Task 1 --> Створити проект бібліотека
- [ ] Task 2 --> Вставити 100 записів у ваші таблиці. У кожній групі по 6 таблиць в 3 таблиці зробити методи, які будуть обгорткою на чистому SQL. У 3 таблиці просто на ОРМ.
  У кожній моделі повинні бути методи на оновлення. В 3 таблиці зробити методи, які будуть обгорткою на чистому SQL. У 3 таблиці просто на ОРМ.
  Зробити по 2 SQL VIEW.
- [ ] Task 3 --> Зробити CRUD форми под кожну модель та додати тести
- [ ] Task 4 --> Додати гем Devise до вашого веб застосунку (повинна бути можливість зареєструватись/залогінитись/востановити пароль)
- [ ] Task 5 --> 1.  зробити root_page (наповнення яке завгодно але повинне бути посилання на  вхід/реєстрацію)
                 2. Пропрацювати інформацію про лікарні, бібліотеки (треба додати назву, рік створення)
                 3.  створити таблиці як на зображені (кожна таблиця повинна мати пагінацію,  якщо ви бачите поля "number of ... " то так це кількість моделей в асоціації 🙂 не треба створвати поле треба його порахувати) (додати CSS) 
                 4. Створити сторінки під кожну модель
                 5. Додати логіку під Пошук та Сортування ----- Створити це за допомогою QueryObject
                 6. Додати тести під кожний елемент
- [ ] Task 6 --> Зробити rake задачу котра буде парсити сайт 
- [ ] Task 7 --> В залежності від того с чим ви працюєте 
                 1) продивитись файл
                 2) додати поля (Street Address,City,Zip Code) до бібліотек та (type, city, RatingMortality) у лікарні
                 3) додати файл до додатка (наразі просто у папку його покладіть)
                 4) розпарсить файл та зберігти дані за допомогою rake задачі
- [ ] Task 8 --> Додати можливість завантажувати 2 файла (СSV, PDF)
- [ ] Task 9 --> Додати паралельне виконання за допомогою Thread
- [ ] Task 10 --> Додати зображення до лікарень, бібліотек, користовачів
- [ ] Task 11 --> Додати active admin до ваших бібліотек або лікарень