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

