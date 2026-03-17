-- =====================================================
-- ПРОЦЕДУРА ЗАГРУЗКИ ТЕСТОВЫХ ДАННЫХ
-- =====================================================
CALL prc_ClearAllTables();
DELIMITER //

CREATE PROCEDURE prc_LoadSampleData()
BEGIN
    -- Очищаем существующие данные перед загрузкой
    
    
    -- 1. Заполнение справочников (родительские таблицы)
    
    -- Pharmacy_points
    INSERT INTO pharmacy_points (title) VALUES 
        ('АП-001'),
        ('АП-002'),
        ('АП-003');
    
    -- Country
    INSERT INTO country (name) VALUES 
        ('Россия'),
        ('Германия'),
        ('США'),
        ('Франция'),
        ('Италия');
    
    -- Brand
    INSERT INTO brand (title) VALUES 
        ('Биокад'),
        ('Фармстандарт'),
        ('Отисифарм'),
        ('Байер'),
        ('Новартис');
    
    -- Manufacturer (зависит от country и brand)
    INSERT INTO manufacturer (country_id, brand_id, title) VALUES 
        (1, 1, 'ФормаПрод'),
        (2, 2, 'ГенИнжен'),
        (3, 3, 'ХиллОлл'),
        (4, 4, 'Байер Фарма'),
        (5, 5, 'Новартис Фарма');
    
    -- Seller
    INSERT INTO seller (surname, name, patronymic, login, password) VALUES 
        ('Иванов', 'Иван', 'Иванович', 'ivanov_i', 'pass123'),
        ('Петров', 'Петр', 'Петрович', 'petrov_p', 'pass456'),
        ('Сидорова', 'Анна', 'Сергеевна', 'sidorova_a', 'pass789');
    
    -- Supplier
    INSERT INTO supplier (title, legal_address, physical_address, okpo, bic, 
                         surname_supplier_representative, name_supplier_representative, 
                         patronymic_supplier_representative) VALUES 
        ('Медикал Групп', 'Москва, ул. Ленина 1', 'Москва, ул. Ленина 1', '12345678', '044525225',
         'Смирнов', 'Алексей', 'Викторович'),
        ('ФармЛогистик', 'СПб, Невский пр. 10', 'СПб, Невский пр. 10', '87654321', '044525226',
         'Козлова', 'Елена', 'Дмитриевна');
    
    -- Buyer
    INSERT INTO buyer (passport_series, passport_number, surname, name, patronymic, 
                      CMI_number, phone_number, disability_certificate_number, pension_certificate_number) VALUES 
        ('4015', '123456', 'Смирнов', 'Андрей', 'Игоревич', '1234567890123456', '+7(999)123-45-67', NULL, NULL),
        ('4016', '654321', 'Кузнецова', 'Мария', 'Александровна', '2234567890123456', '+7(999)234-56-78', NULL, NULL),
        ('4017', '789012', 'Попов', 'Дмитрий', 'Николаевич', '3234567890123456', '+7(999)345-67-89', 'ИНВ-001', NULL),
        ('4018', '345678', 'Васильева', 'Ольга', 'Петровна', '4234567890123456', '+7(999)456-78-90', NULL, 'ПЕНС-001');
    
    -- 2. Заполнение товаров (зависит от manufacturer)
    INSERT INTO goods (article_number, title, structure, simptom, indication, quantity, 
                      method_application, contraindication, manufacturer_id) VALUES 
        ('ЛП-0000001', 'Авапасипам', 'Натуральные цитрусовые и травяные компоненты, натуральная оболочка', 
         'Боль в суставах', 'Острая или тянущая боль в областях локтей', 100, 
         'От боли в суставах', 'Аллергия на витамин С', 1),
        ('ЛП-0000002', 'Фротувазол', 'Витаминный комплекс, растительный состав', 
         'Головная боль', 'Пульсирующая боль в височной области', 150, 
         'От головной и прочей боли', 'Не переносимость гамма элементов', 2),
        ('ЛП-0000003', 'Валокардолин', 'Биологические элементы, пищевая оболочка', 
         'Кашель, сонливость, выделения из носовой полости', 'Профилактика ОРВИ', 200, 
         'Профилактика ОРВИ', 'Сердечная слабость', 3),
        ('ЛП-0000004', 'Редрогедоран', 'Натуральные жиры и масла', 
         'Растяжения, ушибы, подтёки', 'Мышечная боль', 80, 
         'От мышечной боли', 'Почечная недостаточность', 1),
        ('ЛП-0000005', 'Рамеростам', 'Бифитобактерии, микроэлементы', 
         'Заложенность носа, покраснения', 'Аллергия', 120, 
         'Профилактика аллергии', 'Расстройство желудка', 2),
        ('ЛП-0000006', 'Картитозанол', 'Ферменты масел, ферменты микроэлементов', 
         'Отёк конечностей', 'Отёки', 90, 
         'Снятие отёков', 'Непереносимость глюкозы', 3),
        ('ЛП-0000007', 'Флютозипам', 'Натуральные масла', 
         'Тянущая и ноющая боль в сгибах конечностей', 'Мышечное растяжение', 110, 
         'От мышечного растяжения', 'Аллергия на травы', 3);
    
    -- 3. Заполнение связей товаров с аптеками
    INSERT INTO pharmacies_goods (pharmacy_points_id, goods_id) VALUES 
        (1, 1), (1, 2), (1, 3),
        (2, 4), (2, 5), (2, 6),
        (3, 7), (3, 1), (3, 4);
    
    -- 4. Заполнение заказов (зависит от buyer и seller)
    INSERT INTO orders (individual_number, date_and_time_formation, total_cost, discount, 
                       order_status, benefits, buyer_id, seller_id) VALUES 
        ('ЗАКАЗ-001', NOW(), 1500.00, 0, 1, FALSE, 1, 1),
        ('ЗАКАЗ-002', NOW(), 2300.00, 5, 1, FALSE, 2, 2),
        ('ЗАКАЗ-003', NOW(), 3200.00, 10, 2, TRUE, 3, 3),
        ('ЗАКАЗ-004', NOW(), 1800.00, 0, 1, FALSE, 4, 1);
    
    -- 5. Заполнение фискальных чеков
    INSERT INTO fiscal_receipt (date_and_time_formation, receipt_number, discount, 
                               total_cost, amount_money_deposited, benefits) VALUES 
        (NOW(), 'ЧЕК-001', 0, 1500.00, 2000.00, FALSE),
        (NOW(), 'ЧЕК-002', 5, 2300.00, 2300.00, FALSE),
        (NOW(), 'ЧЕК-003', 10, 3200.00, 3500.00, TRUE),
        (NOW(), 'ЧЕК-004', 0, 1800.00, 2000.00, FALSE);
    
    -- 6. Заполнение договоров поставки
    INSERT INTO supply_agreement (quantity, supplier_id, pharmacy_points_id, date_formation, 
                                 date_dispatch, seller_id, total_cost, contract_number) VALUES 
        (100, 1, 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 3 DAY), 1, 50000.00, 'ДОГ-001'),
        (200, 2, 2, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 5 DAY), 2, 75000.00, 'ДОГ-002');
    
    -- 7. Заполнение связей договоров с товарами
    INSERT INTO supply_agreement_goods (supply_agreement_id, goods_id, quantity, price_goods) VALUES 
        (1, 1, 30, 500.00),
        (1, 2, 40, 450.00),
        (2, 4, 50, 600.00),
        (2, 5, 50, 550.00);
    
    -- 8. Заполнение связей чеков с товарами
    INSERT INTO receipts_goods (fiscal_receipt_id, goods_id) VALUES 
        (1, 1), (1, 2),
        (2, 3), (2, 4),
        (3, 5), (3, 6),
        (4, 7);
    
    SELECT 'Тестовые данные успешно загружены' AS result;
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS prc_LoadSampleData;
CALL prc_LoadSampleData();
SELECT 
    g.article_number AS 'Артикул',
    g.title AS 'Наиименование товара',
    g.structure AS 'Состав',
    g.indication AS 'Показания',
    g.quantity AS 'Количество',
    g.method_application AS 'Способ применения',
    g.contraindication AS 'Противопоказания',
    m.title AS 'Производитель',
    b.title AS 'Бренд',
    c.name AS 'Страна'
FROM goods g
JOIN manufacturer m ON g.manufacturer_id = m.id
JOIN brand b ON m.brand_id = b.id
JOIN country c ON m.country_id = c.id
ORDER BY g.title;

-- =====================================================
-- ПРОЦЕДУРА ОЧИСТКИ ВСЕХ ТАБЛИЦ
-- =====================================================
DELIMITER //

CREATE PROCEDURE prc_ClearAllTables()
BEGIN
    -- Отключаем проверку внешних ключей временно
    SET FOREIGN_KEY_CHECKS = 0;
    
    -- Очистка в порядке от дочерних к родительским
    DELETE FROM receipts_goods;
    DELETE FROM supply_agreement_goods;
    DELETE FROM pharmacies_goods;
    DELETE FROM supply_agreement;
    DELETE FROM orders;
    DELETE FROM fiscal_receipt;
    DELETE FROM goods;
    DELETE FROM manufacturer;
    DELETE FROM supplier;
    DELETE FROM seller;
    DELETE FROM buyer;
    DELETE FROM brand;
    DELETE FROM country;
    DELETE FROM pharmacy_points;
    
    -- Включаем проверку внешних ключей обратно
    SET FOREIGN_KEY_CHECKS = 1;
    
    SELECT 'Все таблицы успешно очищены' AS result;
END //

DELIMITER ;

-- =====================================================
-- ЗАПРОСЫ ВЫБОРКИ ДАННЫХ (SELECT)
-- =====================================================

-- 1. Вывод всех товаров с информацией о производителе, бренде и стране
SELECT 
    g.article_number AS 'Артикул',
    g.title AS 'Наименование товара',
    g.structure AS 'Состав',
    g.indication AS 'Показания',
    g.quantity AS 'Количество',
    g.method_application AS 'Способ применения',
    g.contraindication AS 'Противопоказания',
    m.title AS 'Производитель',
    b.title AS 'Бренд',
    c.name AS 'Страна'
FROM goods g
JOIN manufacturer m ON g.manufacturer_id = m.id
JOIN brand b ON m.brand_id = b.id
JOIN country c ON m.country_id = c.id
ORDER BY g.title;

-- 2. Вывод заказов с информацией о покупателях и продавцах
SELECT 
    o.individual_number AS 'Номер заказа',
    o.date_and_time_formation AS 'Дата формирования',
    o.total_cost AS 'Общая стоимость',
    o.discount AS 'Скидка (%)',
    CASE o.order_status 
        WHEN 0 THEN 'Новый'
        WHEN 1 THEN 'В обработке'
        WHEN 2 THEN 'Выполнен'
        WHEN 3 THEN 'Отменен'
        ELSE 'Неизвестен'
    END AS 'Статус заказа',
    CONCAT(b.surname, ' ', b.name, ' ', COALESCE(b.patronymic, '')) AS 'Покупатель',
    b.phone_number AS 'Телефон покупателя',
    CONCAT(s.surname, ' ', s.name, ' ', COALESCE(s.patronymic, '')) AS 'Продавец'
FROM orders o
JOIN buyer b ON o.buyer_id = b.id
JOIN seller s ON o.seller_id = s.id
ORDER BY o.date_and_time_formation DESC;

-- 3. Вывод фискальных чеков с товарами в них
SELECT 
    fr.receipt_number AS 'Номер чека',
    fr.date_and_time_formation AS 'Дата и время',
    fr.discount AS 'Скидка (%)',
    fr.total_cost AS 'Итоговая сумма',
    fr.amount_money_deposited AS 'Внесено',
    (fr.amount_money_deposited - fr.total_cost) AS 'Сдача',
    CASE fr.benefits WHEN TRUE THEN 'Да' ELSE 'Нет' END AS 'Льготы',
    GROUP_CONCAT(g.title SEPARATOR ', ') AS 'Товары в чеке'
FROM fiscal_receipt fr
LEFT JOIN receipts_goods rg ON fr.id = rg.fiscal_receipt_id
LEFT JOIN goods g ON rg.goods_id = g.id
GROUP BY fr.id
ORDER BY fr.date_and_time_formation DESC;

-- 4. Вывод договоров поставки с детализацией товаров
SELECT 
    sa.contract_number AS 'Номер договора',
    sa.date_formation AS 'Дата заключения',
    sa.date_dispatch AS 'Дата отгрузки',
    sup.title AS 'Поставщик',
    pp.title AS 'Аптечный пункт',
    CONCAT(s.surname, ' ', s.name) AS 'Ответственный',
    sa.total_cost AS 'Общая сумма',
    g.title AS 'Товар',
    sag.quantity AS 'Количество',
    sag.price_goods AS 'Цена за ед.',
    (sag.quantity * sag.price_goods) AS 'Сумма по товару'
FROM supply_agreement sa
JOIN supplier sup ON sa.supplier_id = sup.id
JOIN pharmacy_points pp ON sa.pharmacy_points_id = pp.id
JOIN seller s ON sa.seller_id = s.id
JOIN supply_agreement_goods sag ON sa.id = sag.supply_agreement_id
JOIN goods g ON sag.goods_id = g.id
ORDER BY sa.date_formation DESC, sa.contract_number;

-- 5. Вывод остатков товаров по аптекам
SELECT 
    pp.title AS 'Аптечный пункт',
    g.title AS 'Товар',
    g.article_number AS 'Артикул',
    g.quantity AS 'Остаток на складе',
    m.title AS 'Производитель'
FROM pharmacies_goods pg
JOIN pharmacy_points pp ON pg.pharmacy_points_id = pp.id
JOIN goods g ON pg.goods_id = g.id
JOIN manufacturer m ON g.manufacturer_id = m.id
ORDER BY pp.title, g.title;

-- 6. Вывод покупателей с льготами
SELECT 
    CONCAT(surname, ' ', name, ' ', COALESCE(patronymic, '')) AS 'ФИО',
    passport_series AS 'Серия паспорта',
    passport_number AS 'Номер паспорта',
    phone_number AS 'Телефон',
    CASE 
        WHEN disability_certificate_number IS NOT NULL THEN 'Инвалид'
        WHEN pension_certificate_number IS NOT NULL THEN 'Пенсионер'
        ELSE 'Нет льгот'
    END AS 'Тип льготы',
    COALESCE(disability_certificate_number, pension_certificate_number, 'Нет') AS 'Номер документа'
FROM buyer
WHERE disability_certificate_number IS NOT NULL 
   OR pension_certificate_number IS NOT NULL
ORDER BY surname, name;

-- =====================================================
-- ТЕСТИРОВАНИЕ ПРОЦЕДУР
-- =====================================================

-- Очистка всех таблиц
CALL prc_ClearAllTables();

-- Загрузка тестовых данных
CALL prc_LoadSampleData();

-- Проверка загруженных данных
SELECT 'Количество записей в таблицах:' AS info;
SELECT 'pharmacy_points', COUNT(*) FROM pharmacy_points UNION ALL
SELECT 'country', COUNT(*) FROM country UNION ALL
SELECT 'brand', COUNT(*) FROM brand UNION ALL
SELECT 'manufacturer', COUNT(*) FROM manufacturer UNION ALL
SELECT 'seller', COUNT(*) FROM seller UNION ALL
SELECT 'supplier', COUNT(*) FROM supplier UNION ALL
SELECT 'buyer', COUNT(*) FROM buyer UNION ALL
SELECT 'goods', COUNT(*) FROM goods UNION ALL
SELECT 'orders', COUNT(*) FROM orders UNION ALL
SELECT 'fiscal_receipt', COUNT(*) FROM fiscal_receipt;
