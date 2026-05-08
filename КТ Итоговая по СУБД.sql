-- 1 аномалия

SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME
FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
    TABLE_SCHEMA = 'exam_bestfator'
    AND TABLE_NAME = 'loans'
    AND REFERENCED_TABLE_NAME IS NOT NULL;

-- как исправить

ALTER TABLE loans
ADD CONSTRAINT fk_loans_book_id
FOREIGN KEY (book_id) REFERENCES books(id)
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE loans
ADD CONSTRAINT fk_loans_reader_id
FOREIGN KEY (reader_id) REFERENCES readers(id)
ON DELETE SET NULL ON UPDATE CASCADE;

-- 2 аномалия

SELECT id, book_id, reader_id, loan_date, due_date
FROM loans
WHERE due_date < loan_date;

-- как исправить

UPDATE loans
SET due_date = loan_date,
    loan_date = due_date
WHERE due_date < loan_date;

-- 3 аномалия

SHOW INDEX FROM loans WHERE Column_name IN ('loan_date', 'due_date');

-- как исправить

CREATE INDEX idx_loans_loan_date ON loans(loan_date);
CREATE INDEX idx_loans_due_date ON loans(due_date);

-- 4 аномалия

SHOW TRIGGERS FROM exam_bestfator WHERE `Table` = 'loans';

-- как исправить

-- Триггер на выдачу книги (INSERT в loans)
DELIMITER $$
CREATE TRIGGER trg_loans_after_insert
AFTER INSERT ON loans
FOR EACH ROW
BEGIN
    UPDATE books
    SET available_copies = available_copies - 1
    WHERE id = NEW.book_id AND available_copies > 0;
END$$

-- Триггер на возврат книги (UPDATE return_date в loans)
CREATE TRIGGER trg_loans_after_update
AFTER UPDATE ON loans
FOR EACH ROW
BEGIN
    IF OLD.return_date IS NULL AND NEW.return_date IS NOT NULL THEN
        UPDATE books
        SET available_copies = available_copies + 1
        WHERE id = NEW.book_id;
    END IF;
END$$
DELIMITER ;

-- 5 аномалия

SHOW FULL TABLES IN exam_bestfator WHERE Tables_in_exam_bestfator = 'active_loans';

-- как исправить

-- Создать представление
CREATE VIEW active_loans_view AS
SELECT * FROM loans WHERE return_date IS NULL;

-- Удалить старую таблицу (если не нужна)
DROP TABLE active_loans;

-- 6 аномалия

SHOW PROCEDURE STATUS WHERE DB = 'exam_bestfator';

-- как исправить

DELIMITER $$
CREATE PROCEDURE return_book(IN p_loan_id INT)
BEGIN
    DECLARE v_days_late INT;
    DECLARE v_book_id INT;
    DECLARE v_due_date DATE;
    
    -- Получить информацию о выдаче
    SELECT book_id, due_date INTO v_book_id, v_due_date
    FROM loans
    WHERE id = p_loan_id AND return_date IS NULL;
    
    -- Рассчитать дни просрочки
    SET v_days_late = DATEDIFF(CURDATE(), v_due_date);
    
    -- Обновить дату возврата
    UPDATE loans
    SET return_date = CURDATE()
    WHERE id = p_loan_id;
    
    -- Если есть просрочка — создать штраф
    IF v_days_late > 0 THEN
        INSERT INTO fines (loan_id, amount, issued_date)
        VALUES (p_loan_id, v_days_late * 0.50, CURDATE());
    END IF;
    
    SELECT 'Книга успешно возвращена' AS message;
END$$
DELIMITER ;

-- Дополнительные аномалии

-- 1 аномалия

DESCRIBE books;

-- как исправить

ALTER TABLE books DROP COLUMN author;

-- 2 аномалия

SELECT COUNT(*) FROM loans WHERE return_date IS NULL;
SELECT COUNT(*) FROM active_loans;

-- как исправить

-- удалить active_loans и использовать представление

-- 3 аномалия

-- нет диагностического запроса

-- как исправить

ALTER TABLE books
ADD CONSTRAINT chk_copies CHECK (total_copies >= 0 AND available_copies >= 0);

-- 4 аномалия

-- нет диагностического запроса

-- как исправить

ALTER TABLE loans
ADD CONSTRAINT chk_status CHECK (status IN ('active', 'returned', 'lost'));
