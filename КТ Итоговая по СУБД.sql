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

