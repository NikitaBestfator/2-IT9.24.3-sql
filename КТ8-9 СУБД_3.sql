-- Администратор
-- Полный доступ ко всем таблицам
GRANT ALL PRIVILEGES ON Patients TO 'administrator';
GRANT ALL PRIVILEGES ON Doctors TO 'administrator';
GRANT ALL PRIVILEGES ON Drugs TO 'administrator';
GRANT ALL PRIVILEGES ON Prescriptions TO 'administrator';
GRANT ALL PRIVILEGES ON Prescription_Items TO 'administrator';
GRANT ALL PRIVILEGES ON Prescription_Sales TO 'administrator';

-- Полный доступ к хранимым процедурам
GRANT EXECUTE ON PROCEDURE AddPrescriptionSale TO 'administrator';
GRANT EXECUTE ON PROCEDURE AddPrescription TO 'administrator';
GRANT EXECUTE ON PROCEDURE AddPrescriptionItem TO 'administrator';
GRANT EXECUTE ON PROCEDURE GetRemainingQuantity TO 'administrator';
GRANT EXECUTE ON PROCEDURE CheckRemainingQuantity TO 'administrator';
GRANT EXECUTE ON PROCEDURE CheckPrescriptionValidity TO 'administrator';
GRANT EXECUTE ON PROCEDURE GetActivePatientPrescriptions TO 'administrator';
GRANT EXECUTE ON PROCEDURE CheckUniquePrescriptionNumber TO 'administrator';
GRANT EXECUTE ON PROCEDURE ProcessSale TO 'administrator';

-- Возможность назначать права другим
GRANT GRANT OPTION ON *.* TO 'administrator';

-- Клиент
-- Только чтение таблиц
GRANT SELECT ON Patients TO 'client';
GRANT SELECT ON Prescriptions TO 'client';
GRANT SELECT ON Prescription_Items TO 'client';
GRANT SELECT ON Prescription_Sales TO 'client';
GRANT SELECT ON Drugs TO 'client';
GRANT SELECT ON Doctors TO 'client';

-- Выполнение процедур для проверки своих рецептов
GRANT EXECUTE ON PROCEDURE GetRemainingQuantity TO 'client';
GRANT EXECUTE ON PROCEDURE CheckPrescriptionValidity TO 'client';
GRANT EXECUTE ON PROCEDURE GetActivePatientPrescriptions TO 'client';

-- Примечание: INSERT/UPDATE/DELETE права НЕ выдаются (их и так нет)

-- Производитель
-- Полный доступ к препаратам
GRANT SELECT, INSERT, UPDATE, DELETE ON Drugs TO 'manufacturer';

-- Просмотр рецептов (для анализа спроса)
GRANT SELECT ON Prescriptions TO 'manufacturer';
GRANT SELECT ON Prescription_Items TO 'manufacturer';
GRANT SELECT ON Prescription_Sales TO 'manufacturer';

-- Ограниченный просмотр врачей и пациентов (только нужные поля)
GRANT SELECT (id, specialty) ON Doctors TO 'manufacturer';
GRANT SELECT (id, birth_date) ON Patients TO 'manufacturer';

-- Выполнение процедур
GRANT EXECUTE ON PROCEDURE GetRemainingQuantity TO 'manufacturer';

-- Запрет на изменение рецептов и продаж (просто не выдаём права)
-- INSERT, UPDATE, DELETE на Prescriptions, Prescription_Items, Prescription_Sales - НЕ выдаём

-- Поставщик
-- Только просмотр
GRANT SELECT ON Drugs TO 'supplier';
GRANT SELECT ON Prescription_Items TO 'supplier';
GRANT SELECT ON Prescription_Sales TO 'supplier';
GRANT SELECT ON Prescriptions TO 'supplier';

-- Выполнение процедур
GRANT EXECUTE ON PROCEDURE GetRemainingQuantity TO 'supplier';

-- Примечание: INSERT/UPDATE/DELETE права НЕ выдаются

-- Врачи или фармацевты
-- Полный доступ к продажам и рецептам (кроме удаления)
GRANT SELECT, INSERT, UPDATE ON Prescriptions TO 'pharmacist';
GRANT SELECT, INSERT, UPDATE ON Prescription_Items TO 'pharmacist';
GRANT SELECT, INSERT, UPDATE ON Prescription_Sales TO 'pharmacist';

-- Просмотр препаратов, пациентов, врачей
GRANT SELECT ON Drugs TO 'pharmacist';
GRANT SELECT ON Patients TO 'pharmacist';
GRANT SELECT ON Doctors TO 'pharmacist';

-- Выполнение всех процедур для работы с рецептами
GRANT EXECUTE ON PROCEDURE AddPrescriptionSale TO 'pharmacist';
GRANT EXECUTE ON PROCEDURE AddPrescription TO 'pharmacist';
GRANT EXECUTE ON PROCEDURE AddPrescriptionItem TO 'pharmacist';
GRANT EXECUTE ON PROCEDURE GetRemainingQuantity TO 'pharmacist';
GRANT EXECUTE ON PROCEDURE CheckRemainingQuantity TO 'pharmacist';
GRANT EXECUTE ON PROCEDURE CheckPrescriptionValidity TO 'pharmacist';
GRANT EXECUTE ON PROCEDURE GetActivePatientPrescriptions TO 'pharmacist';
GRANT EXECUTE ON PROCEDURE ProcessSale TO 'pharmacist';

-- DELETE права НЕ выдаём (фармацевт не должен удалять записи)
