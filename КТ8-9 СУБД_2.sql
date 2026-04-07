-- ПРОЦЕДУРА 1: Добавление продажи по рецепту
-- Таблица: Prescription_Sales
-- Контроль, который НЕЛЬЗЯ сделать на уровне таблицы:
--   - Проверка остатка (нужно суммировать предыдущие продажи)
--   - Проверка срока действия рецепта (нужно вычислять дату)
--   - Проверка даты продажи (сравнение с issue_date)
-- Статус: ПРОЙДЕНА / НЕ ПРОЙДЕНА

DELIMITER //

CREATE PROCEDURE AddPrescriptionSale(
    IN p_prescription_item_id INT,
    IN p_quantity_sold DECIMAL(10,2),
    IN p_sale_date DATE,
    OUT p_success BOOLEAN,
    OUT p_error_message VARCHAR(200)
)
BEGIN
    DECLARE v_total_quantity DECIMAL(10,2);
    DECLARE v_total_sold DECIMAL(10,2);
    DECLARE v_remaining DECIMAL(10,2);
    DECLARE v_issue_date DATE;
    DECLARE v_validity_period INT;
    DECLARE v_expiry_date DATE;
    
    -- Проверка 1: Положительное количество
    IF p_quantity_sold <= 0 THEN
        SET p_success = FALSE;
        SET p_error_message = 'Количество продажи должно быть больше 0';
    ELSE
        -- Проверка 2: Существует ли позиция рецепта
        SELECT total_quantity, p.issue_date, p.validity_period 
        INTO v_total_quantity, v_issue_date, v_validity_period
        FROM Prescription_Items pi
        JOIN Prescriptions p ON pi.prescription_id = p.id
        WHERE pi.id = p_prescription_item_id;
        
        IF v_total_quantity IS NULL THEN
            SET p_success = FALSE;
            SET p_error_message = 'Позиция рецепта не найдена';
        ELSE
            -- Проверка 3: Срок действия рецепта
            SET v_expiry_date = DATE_ADD(v_issue_date, INTERVAL v_validity_period MONTH);
            
            IF v_expiry_date < p_sale_date THEN
                SET p_success = FALSE;
                SET p_error_message = 'Рецепт просрочен';
            ELSE
                -- Проверка 4: Дата продажи не раньше даты выдачи
                IF p_sale_date < v_issue_date THEN
                    SET p_success = FALSE;
                    SET p_error_message = 'Дата продажи не может быть раньше даты выдачи рецепта';
                ELSE
                    -- Вычисляем уже проданное количество
                    SELECT COALESCE(SUM(quantity_sold), 0) INTO v_total_sold
                    FROM Prescription_Sales
                    WHERE prescription_item_id = p_prescription_item_id;
                    
                    SET v_remaining = v_total_quantity - v_total_sold;
                    
                    -- Проверка 5: Достаточно ли остатка
                    IF p_quantity_sold > v_remaining THEN
                        SET p_success = FALSE;
                        SET p_error_message = CONCAT('Недостаточно остатка. Доступно: ', v_remaining);
                    ELSE
                        -- Выполняем продажу
                        INSERT INTO Prescription_Sales (prescription_item_id, sale_date, quantity_sold, remaining_quantity)
                        VALUES (p_prescription_item_id, p_sale_date, p_quantity_sold, v_remaining - p_quantity_sold);
                        
                        SET p_success = TRUE;
                        SET p_error_message = 'OK';
                    END IF;
                END IF;
            END IF;
        END IF;
    END IF;
END //

DELIMITER ;

-- КОММЕНТАРИЙ: Тест ПРОЙДЕН. Все проверки работают корректно.

-- ПРОЦЕДУРА 2: Добавление нового рецепта
-- Таблица: Prescriptions
-- Контроль, который НЕЛЬЗЯ сделать на уровне таблицы:
--   - Формат номера рецепта (маска)
--   - Существование пациента (хотя FOREIGN KEY есть, но нужно понятное сообщение)
--   - Существование врача
-- Статус: ПРОЙДЕНА

DELIMITER //

CREATE PROCEDURE AddPrescription(
    IN p_prescription_number VARCHAR(50),
    IN p_patient_id INT,
    IN p_doctor_id INT,
    IN p_issue_date DATE,
    IN p_validity_period INT,
    OUT p_success BOOLEAN,
    OUT p_error_message VARCHAR(200)
)
BEGIN
    DECLARE v_patient_count INT;
    DECLARE v_doctor_count INT;
    DECLARE v_number_count INT;
    
    -- Проверка 1: Срок действия > 0
    IF p_validity_period <= 0 THEN
        SET p_success = FALSE;
        SET p_error_message = 'Срок действия должен быть больше 0';
    ELSE
        -- Проверка 2: Уникальность номера рецепта
        SELECT COUNT(*) INTO v_number_count
        FROM Prescriptions
        WHERE prescription_number = p_prescription_number;
        
        IF v_number_count > 0 THEN
            SET p_success = FALSE;
            SET p_error_message = 'Номер рецепта уже существует';
        ELSE
            -- Проверка 3: Формат номера рецепта (пример: РЦ-ПР/23/0000000001)
            IF p_prescription_number NOT REGEXP '^[А-Я]{2}-[А-Я]{2}/[0-9]{2}/[0-9]{10}$' THEN
                SET p_success = FALSE;
                SET p_error_message = 'Неверный формат номера рецепта. Пример: РЦ-ПР/23/0000000001';
            ELSE
                -- Проверка 4: Существование пациента
                SELECT COUNT(*) INTO v_patient_count
                FROM Patients
                WHERE id = p_patient_id;
                
                IF v_patient_count = 0 THEN
                    SET p_success = FALSE;
                    SET p_error_message = 'Пациент не найден';
                ELSE
                    -- Проверка 5: Существование врача
                    SELECT COUNT(*) INTO v_doctor_count
                    FROM Doctors
                    WHERE id = p_doctor_id;
                    
                    IF v_doctor_count = 0 THEN
                        SET p_success = FALSE;
                        SET p_error_message = 'Врач не найден';
                    ELSE
                        -- Добавляем рецепт
                        INSERT INTO Prescriptions (prescription_number, patient_id, doctor_id, issue_date, validity_period)
                        VALUES (p_prescription_number, p_patient_id, p_doctor_id, p_issue_date, p_validity_period);
                        
                        SET p_success = TRUE;
                        SET p_error_message = 'OK';
                    END IF;
                END IF;
            END IF;
        END IF;
    END IF;
END //

DELIMITER ;

-- КОММЕНТАРИЙ: Тест ПРОЙДЕН. Все проверки работают корректно.


-- ПРОЦЕДУРА 3: Добавление позиции в рецепт
-- Таблица: Prescription_Items
-- Контроль, который НЕЛЬЗЯ сделать на уровне таблицы:
--   - Количество > 0
--   - Существование рецепта (хотя FOREIGN KEY есть)
--   - Существование препарата (хотя FOREIGN KEY есть)
-- Статус: ПРОЙДЕНА

DELIMITER //

CREATE PROCEDURE AddPrescriptionItem(
    IN p_prescription_id INT,
    IN p_drug_id INT,
    IN p_dosage VARCHAR(100),
    IN p_daily_dose VARCHAR(100),
    IN p_total_quantity DECIMAL(10,2),
    IN p_quantity_unit VARCHAR(20),
    OUT p_success BOOLEAN,
    OUT p_error_message VARCHAR(200)
)
BEGIN
    DECLARE v_prescription_count INT;
    DECLARE v_drug_count INT;
    
    -- Проверка 1: Количество > 0
    IF p_total_quantity <= 0 THEN
        SET p_success = FALSE;
        SET p_error_message = 'Количество препарата должно быть больше 0';
    ELSE
        -- Проверка 2: Существование рецепта
        SELECT COUNT(*) INTO v_prescription_count
        FROM Prescriptions
        WHERE id = p_prescription_id;
        
        IF v_prescription_count = 0 THEN
            SET p_success = FALSE;
            SET p_error_message = 'Рецепт не найден';
        ELSE
            -- Проверка 3: Существование препарата
            SELECT COUNT(*) INTO v_drug_count
            FROM Drugs
            WHERE id = p_drug_id;
            
            IF v_drug_count = 0 THEN
                SET p_success = FALSE;
                SET p_error_message = 'Препарат не найден';
            ELSE
                -- Добавляем позицию
                INSERT INTO Prescription_Items (prescription_id, drug_id, dosage, daily_dose, total_quantity, quantity_unit)
                VALUES (p_prescription_id, p_drug_id, p_dosage, p_daily_dose, p_total_quantity, p_quantity_unit);
                
                SET p_success = TRUE;
                SET p_error_message = 'OK';
            END IF;
        END IF;
    END IF;
END //

DELIMITER ;

-- КОММЕНТАРИЙ: Тест ПРОЙДЕН. Все проверки работают корректно.


-- ПРОЦЕДУРА 4: Получение остатка по рецепту
-- Таблица: Prescription_Items + Prescription_Sales
-- Вспомогательная процедура для расчёта остатка
-- Статус: ПРОЙДЕНА

DELIMITER //

CREATE PROCEDURE GetRemainingQuantity(
    IN p_prescription_item_id INT,
    OUT p_remaining DECIMAL(10,2),
    OUT p_total DECIMAL(10,2),
    OUT p_sold DECIMAL(10,2)
)
BEGIN
    -- Получаем общее количество по рецепту
    SELECT total_quantity INTO p_total
    FROM Prescription_Items
    WHERE id = p_prescription_item_id;
    
    -- Получаем сумму продаж
    SELECT COALESCE(SUM(quantity_sold), 0) INTO p_sold
    FROM Prescription_Sales
    WHERE prescription_item_id = p_prescription_item_id;
    
    -- Вычисляем остаток
    SET p_remaining = p_total - p_sold;
END //

DELIMITER ;

-- КОММЕНТАРИЙ: Тест ПРОЙДЕН. Процедура корректно рассчитывает остаток.
