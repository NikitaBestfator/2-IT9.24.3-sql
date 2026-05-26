-- ============================================================
-- schema.sql - создание всех таблиц в правильном порядке
-- ============================================================

SET FOREIGN_KEY_CHECKS = 0;

-- 1. Таблицы без внешних ключей (родительские)
CREATE TABLE IF NOT EXISTS authors (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(200) NOT NULL,
    birth_year INT,
    country VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS genres (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS readers (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(200) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    registered_date DATE DEFAULT (CURDATE()),
    address TEXT
);

CREATE TABLE IF NOT EXISTS books (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(300) NOT NULL,
    author VARCHAR(200),
    isbn VARCHAR(20) UNIQUE,
    publisher VARCHAR(200),
    year INT,
    total_copies INT DEFAULT 1,
    available_copies INT DEFAULT 1
);

-- 2. Связующие таблицы (многие-ко-многим)
CREATE TABLE IF NOT EXISTS book_authors (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS book_genres (
    book_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (book_id, genre_id),
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
);

-- 3. Таблицы с внешними ключами (дочерние)
CREATE TABLE IF NOT EXISTS loans (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    reader_id INT,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status VARCHAR(20) DEFAULT 'active',
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE SET NULL,
    FOREIGN KEY (reader_id) REFERENCES readers(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS fines (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    loan_id INT,
    amount DECIMAL(10,2) NOT NULL,
    issued_date DATE NOT NULL,
    paid_date DATE,
    waived_reason TEXT,
    FOREIGN KEY (loan_id) REFERENCES loans(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS reservations (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    reader_id INT,
    reserve_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    notification_sent TINYINT(1) DEFAULT 0,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE SET NULL,
    FOREIGN KEY (reader_id) REFERENCES readers(id) ON DELETE SET NULL
);

-- 4. Таблица active_loans (отдельная таблица, не VIEW - по желанию)

CREATE TABLE IF NOT EXISTS active_loans (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(300) NOT NULL,
    reader_name VARCHAR(200) NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL
);

SET FOREIGN_KEY_CHECKS = 1;
