-- ============================================================
-- data.sql - INSERT-ы для всех таблиц
-- Сгенерировано: 2026-05-26
-- Запросы-генераторы находятся в файле generate_data.sql
-- ============================================================

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO authors (id, full_name, birth_year, country) VALUES (1, 'Лев Толстой', 1828, 'Россия'), (2, 'Фёдор Достоевский', 1821, 'Россия'), (3, 'Джордж Оруэлл', 1903, 'Великобритания');

INSERT INTO genres (id, name, description) VALUES (1, 'Роман', 'Крупное повествовательное произведение'), (2, 'Фантастика', 'Литература о вымышленных мирах'), (3, 'Детектив', 'Литература о расследованиях');

INSERT INTO readers (id, full_name, email, phone, registered_date, address) VALUES (1, 'Иван Петров', 'ivan@example.com', '+7 123 456-78-90', '2024-01-15', 'Москва, ул. Пушкина 10'), (2, 'Мария Сидорова', 'maria@example.com', '+7 123 456-78-91', '2024-02-20', 'Санкт-Петербург, Невский пр. 25');

INSERT INTO books (id, title, author, isbn, publisher, year, total_copies, available_copies) VALUES (1, 'Война и мир', 'Лев Толстой', '978-5-17-118614-2', 'АСТ', 1869, 5, 4), (2, 'Преступление и наказание', 'Фёдор Достоевский', '978-5-04-109478-2', 'Эксмо', 1866, 3, 2), (3, '1984', 'Джордж Оруэлл', '978-5-17-118614-2', 'АСТ', 1949, 4, 4);

INSERT INTO book_authors (book_id, author_id) VALUES (1, 1), (2, 2), (3, 3);

INSERT INTO book_genres (book_id, genre_id) VALUES (1, 1), (2, 1), (3, 2);

INSERT INTO loans (id, book_id, reader_id, loan_date, due_date, return_date, status) VALUES (1, 1, 1, '2025-05-01', '2025-05-15', NULL, 'active'), (2, 2, 2, '2025-04-25', '2025-05-09', '2025-05-08', 'returned');

INSERT INTO fines (id, loan_id, amount, issued_date, paid_date, waived_reason) VALUES (1, 1, 50.00, '2025-05-16', NULL, NULL);

INSERT INTO reservations (id, book_id, reader_id, reserve_date, expiry_date, notification_sent) VALUES (1, 1, 2, '2025-05-10', '2025-05-20', 0);

INSERT INTO active_loans (id, title, reader_name, loan_date, due_date) VALUES (1, 'Война и мир', 'Иван Петров', '2025-05-01', '2025-05-15'), (2, '1984', 'Мария Сидорова', '2025-05-02', '2025-05-16');

SET FOREIGN_KEY_CHECKS = 1;
