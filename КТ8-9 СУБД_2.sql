-- =====================================================
-- ТЕСТ 1: Проверка уникальности названия препарата
-- Описание: Ввод существующего лекарственного средства
-- Ожидаемый результат: Указанное название уже есть в таблице!
-- Статус: ПРОЙДЕН
-- =====================================================

DELIMITER //

CREATE PROCEDURE CheckDrugUnique(
    IN p_drug_name VARCHAR(200),
    OUT p_exists BOOLEAN,
    OUT p_message VARCHAR(200)
)
BEGIN
    DECLARE v_count INT;
    
    SELECT COUNT(*) INTO v_count
    FROM Drugs
    WHERE name = p_drug_name;
    
    IF v_count > 0 THEN
        SET p_exists = TRUE;
        SET p_message = 'Указанное название уже есть в таблице!';
    ELSE
        SET p_exists = FALSE;
        SET p_message = 'Название свободно';
    END IF;
END //

DELIMITER ;

-- Вызов теста
CALL CheckDrugUnique('Валокардолин', @exists, @message);
SELECT @exists, @message;
-- Ожидаемый результат: TRUE, 'Указанное название уже есть в таблице!'
