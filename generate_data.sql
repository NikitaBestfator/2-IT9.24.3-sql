-- ============================================================
-- Генерация INSERT-запросов для всех таблиц
-- ============================================================

SET SESSION group_concat_max_len = 1000000;

-- 1. authors
SELECT CONCAT(
    'INSERT INTO authors (id, full_name, birth_year, country) VALUES ',
    GROUP_CONCAT(
        CONCAT('(', IFNULL(id, 'NULL'), ', ', QUOTE(full_name), ', ', IFNULL(birth_year, 'NULL'), ', ', IFNULL(QUOTE(country), 'NULL'), ')')
        SEPARATOR ', '
    ),
    ';'
) AS insert_statement FROM authors;

-- 2. genres
SELECT CONCAT(
    'INSERT INTO genres (id, name, description) VALUES ',
    GROUP_CONCAT(
        CONCAT('(', IFNULL(id, 'NULL'), ', ', QUOTE(name), ', ', IFNULL(QUOTE(description), 'NULL'), ')')
        SEPARATOR ', '
    ),
    ';'
) AS insert_statement FROM genres;

-- 3. readers
SELECT CONCAT(
    'INSERT INTO readers (id, full_name, email, phone, registered_date, address) VALUES ',
    GROUP_CONCAT(
        CONCAT('(', IFNULL(id, 'NULL'), ', ', QUOTE(full_name), ', ', IFNULL(QUOTE(email), 'NULL'), ', ', IFNULL(QUOTE(phone), 'NULL'), ', ', IFNULL(QUOTE(registered_date), 'NULL'), ', ', IFNULL(QUOTE(address), 'NULL'), ')')
        SEPARATOR ', '
    ),
    ';'
) AS insert_statement FROM readers;

-- 4. books
SELECT CONCAT(
    'INSERT INTO books (id, title, author, isbn, publisher, year, total_copies, available_copies) VALUES ',
    GROUP_CONCAT(
        CONCAT('(', IFNULL(id, 'NULL'), ', ', QUOTE(title), ', ', IFNULL(QUOTE(author), 'NULL'), ', ', IFNULL(QUOTE(isbn), 'NULL'), ', ', IFNULL(QUOTE(publisher), 'NULL'), ', ', IFNULL(year, 'NULL'), ', ', IFNULL(total_copies, 'NULL'), ', ', IFNULL(available_copies, 'NULL'), ')')
        SEPARATOR ', '
    ),
    ';'
) AS insert_statement FROM books;

-- 5. book_authors
SELECT CONCAT(
    'INSERT INTO book_authors (book_id, author_id) VALUES ',
    GROUP_CONCAT(
        CONCAT('(', IFNULL(book_id, 'NULL'), ', ', IFNULL(author_id, 'NULL'), ')')
        SEPARATOR ', '
    ),
    ';'
) AS insert_statement FROM book_authors;

-- 6. book_genres
SELECT CONCAT(
    'INSERT INTO book_genres (book_id, genre_id) VALUES ',
    GROUP_CONCAT(
        CONCAT('(', IFNULL(book_id, 'NULL'), ', ', IFNULL(genre_id, 'NULL'), ')')
        SEPARATOR ', '
    ),
    ';'
) AS insert_statement FROM book_genres;

-- 7. loans
SELECT CONCAT(
    'INSERT INTO loans (id, book_id, reader_id, loan_date, due_date, return_date, status) VALUES ',
    GROUP_CONCAT(
        CONCAT('(', IFNULL(id, 'NULL'), ', ', IFNULL(book_id, 'NULL'), ', ', IFNULL(reader_id, 'NULL'), ', ', IFNULL(QUOTE(loan_date), 'NULL'), ', ', IFNULL(QUOTE(due_date), 'NULL'), ', ', IFNULL(QUOTE(return_date), 'NULL'), ', ', IFNULL(QUOTE(status), 'NULL'), ')')
        SEPARATOR ', '
    ),
    ';'
) AS insert_statement FROM loans;

-- 8. fines
SELECT CONCAT(
    'INSERT INTO fines (id, loan_id, amount, issued_date, paid_date, waived_reason) VALUES ',
    GROUP_CONCAT(
        CONCAT('(', IFNULL(id, 'NULL'), ', ', IFNULL(loan_id, 'NULL'), ', ', IFNULL(amount, 'NULL'), ', ', IFNULL(QUOTE(issued_date), 'NULL'), ', ', IFNULL(QUOTE(paid_date), 'NULL'), ', ', IFNULL(QUOTE(waived_reason), 'NULL'), ')')
        SEPARATOR ', '
    ),
    ';'
) AS insert_statement FROM fines;

-- 9. reservations
SELECT CONCAT(
    'INSERT INTO reservations (id, book_id, reader_id, reserve_date, expiry_date, notification_sent) VALUES ',
    GROUP_CONCAT(
        CONCAT('(', IFNULL(id, 'NULL'), ', ', IFNULL(book_id, 'NULL'), ', ', IFNULL(reader_id, 'NULL'), ', ', IFNULL(QUOTE(reserve_date), 'NULL'), ', ', IFNULL(QUOTE(expiry_date), 'NULL'), ', ', IFNULL(notification_sent, 'NULL'), ')')
        SEPARATOR ', '
    ),
    ';'
) AS insert_statement FROM reservations;

-- 10. active_loans
SELECT CONCAT(
    'INSERT INTO active_loans (id, title, reader_name, loan_date, due_date) VALUES ',
    GROUP_CONCAT(
        CONCAT('(', IFNULL(id, 'NULL'), ', ', QUOTE(title), ', ', QUOTE(reader_name), ', ', IFNULL(QUOTE(loan_date), 'NULL'), ', ', IFNULL(QUOTE(due_date), 'NULL'), ')')
        SEPARATOR ', '
    ),
    ';'
) AS insert_statement FROM active_loans;
