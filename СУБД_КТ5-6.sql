DELIMITER //

CREATE PROCEDURE Pharmacy_points_Insert(IN p_title VARCHAR(20))
BEGIN
    INSERT INTO pharmacy_points (title) VALUES (p_title);
    SELECT LAST_INSERT_ID() AS new_id;
END //
DELIMITER ;
DELIMITER //

CREATE PROCEDURE Pharmacy_points_Update(IN p_id INT, IN p_title VARCHAR(20))
BEGIN
    UPDATE pharmacy_points 
    SET title = COALESCE(p_title, title)
    WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_affected;
END //
DELIMITER ;
DELIMITER //

CREATE PROCEDURE Pharmacy_points_Delete(IN p_id INT)
BEGIN
    DELETE FROM pharmacy_points WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_deleted;
END //
DELIMITER ;



DELIMITER //

CREATE PROCEDURE Seller_Insert(
    IN p_surname VARCHAR(45),
    IN p_name VARCHAR(45),
    IN p_patronymic VARCHAR(45),
    IN p_login VARCHAR(45),
    IN p_password VARCHAR(45)
)
BEGIN
    INSERT INTO seller (surname, name, patronymic, login, password) 
    VALUES (p_surname, p_name, p_patronymic, p_login, p_password);
    SELECT LAST_INSERT_ID() AS new_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Seller_Update(
    IN p_id INT,
    IN p_surname VARCHAR(45),
    IN p_name VARCHAR(45),
    IN p_patronymic VARCHAR(45),
    IN p_login VARCHAR(45),
    IN p_password VARCHAR(45)
)
BEGIN
    UPDATE seller 
    SET 
        surname = COALESCE(p_surname, surname),
        name = COALESCE(p_name, name),
        patronymic = COALESCE(p_patronymic, patronymic),
        login = COALESCE(p_login, login),
        password = COALESCE(p_password, password)
    WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_affected;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Seller_Delete(IN p_id INT)
BEGIN
    DELETE FROM seller WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_deleted;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE Fiscal_receipt_Insert(
    IN p_date_and_time_formation DATETIME,
    IN p_receipt_number VARCHAR(45),
    IN p_discount DECIMAL,
    IN p_total_cost DECIMAL,
    IN p_amount_money_deposited DECIMAL,
    IN p_benefits BOOLEAN
)
BEGIN
    INSERT INTO fiscal_receipt 
        (date_and_time_formation, receipt_number, discount, total_cost, amount_money_deposited, benefits) 
    VALUES 
        (p_date_and_time_formation, p_receipt_number, p_discount, p_total_cost, p_amount_money_deposited, p_benefits);
    SELECT LAST_INSERT_ID() AS new_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Fiscal_receipt_Update(
    IN p_id INT,
    IN p_date_and_time_formation DATETIME,
    IN p_receipt_number VARCHAR(45),
    IN p_discount DECIMAL,
    IN p_total_cost DECIMAL,
    IN p_amount_money_deposited DECIMAL,
    IN p_benefits BOOLEAN
)
BEGIN
    UPDATE fiscal_receipt 
    SET 
        date_and_time_formation = COALESCE(p_date_and_time_formation, date_and_time_formation),
        receipt_number = COALESCE(p_receipt_number, receipt_number),
        discount = COALESCE(p_discount, discount),
        total_cost = COALESCE(p_total_cost, total_cost),
        amount_money_deposited = COALESCE(p_amount_money_deposited, amount_money_deposited),
        benefits = COALESCE(p_benefits, benefits)
    WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_affected;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Fiscal_receipt_Delete(IN p_id INT)
BEGIN
    DELETE FROM fiscal_receipt WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_deleted;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE Supplier_Insert(
    IN p_title VARCHAR(45),
    IN p_legal_address VARCHAR(45),
    IN p_physical_address VARCHAR(45),
    IN p_okpo VARCHAR(45),
    IN p_bic VARCHAR(45),
    IN p_surname_supplier_representative BOOLEAN,
    IN p_name_supplier_representative BOOLEAN,
    IN p_patronymic_supplier_representative BOOLEAN
)
BEGIN
    INSERT INTO supplier 
        (title, legal_address, physical_address, okpo, bic, surname_supplier_representative, 
         name_supplier_representative, patronymic_supplier_representative) 
    VALUES 
        (p_title, p_legal_address, p_physical_address, p_okpo, p_bic, 
         p_surname_supplier_representative, p_name_supplier_representative, p_patronymic_supplier_representative);
    SELECT LAST_INSERT_ID() AS new_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Supplier_Update(
    IN p_id INT,
    IN p_title VARCHAR(45),
    IN p_legal_address VARCHAR(45),
    IN p_physical_address VARCHAR(45),
    IN p_okpo VARCHAR(45),
    IN p_bic VARCHAR(45),
    IN p_surname_supplier_representative BOOLEAN,
    IN p_name_supplier_representative BOOLEAN,
    IN p_patronymic_supplier_representative BOOLEAN
)
BEGIN
    UPDATE supplier 
    SET 
        title = COALESCE(p_title, title),
        legal_address = COALESCE(p_legal_address, legal_address),
        physical_address = COALESCE(p_physical_address, physical_address),
        okpo = COALESCE(p_okpo, okpo),
        bic = COALESCE(p_bic, bic),
        surname_supplier_representative = COALESCE(p_surname_supplier_representative, surname_supplier_representative),
        name_supplier_representative = COALESCE(p_name_supplier_representative, name_supplier_representative),
        patronymic_supplier_representative = COALESCE(p_patronymic_supplier_representative, patronymic_supplier_representative)
    WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_affected;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Supplier_Delete(IN p_id INT)
BEGIN
    DELETE FROM supplier WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_deleted;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE Buyer_Insert(
    IN p_passport_series VARCHAR(45),
    IN p_passport_number VARCHAR(45),
    IN p_surname VARCHAR(45),
    IN p_name VARCHAR(45),
    IN p_patronymic VARCHAR(45),
    IN p_CMI_number VARCHAR(45),
    IN p_phone_number VARCHAR(45),
    IN p_disability_certificate_number VARCHAR(45),
    IN p_pension_certificate_number VARCHAR(45)
)
BEGIN
    INSERT INTO buyer 
        (passport_series, passport_number, surname, name, patronymic, CMI_number, 
         phone_number, disability_certificate_number, pension_certificate_number) 
    VALUES 
        (p_passport_series, p_passport_number, p_surname, p_name, p_patronymic, p_CMI_number,
         p_phone_number, p_disability_certificate_number, p_pension_certificate_number);
    SELECT LAST_INSERT_ID() AS new_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Buyer_Update(
    IN p_id INT,
    IN p_passport_series VARCHAR(45),
    IN p_passport_number VARCHAR(45),
    IN p_surname VARCHAR(45),
    IN p_name VARCHAR(45),
    IN p_patronymic VARCHAR(45),
    IN p_CMI_number VARCHAR(45),
    IN p_phone_number VARCHAR(45),
    IN p_disability_certificate_number VARCHAR(45),
    IN p_pension_certificate_number VARCHAR(45)
)
BEGIN
    UPDATE buyer 
    SET 
        passport_series = COALESCE(p_passport_series, passport_series),
        passport_number = COALESCE(p_passport_number, passport_number),
        surname = COALESCE(p_surname, surname),
        name = COALESCE(p_name, name),
        patronymic = COALESCE(p_patronymic, patronymic),
        CMI_number = COALESCE(p_CMI_number, CMI_number),
        phone_number = COALESCE(p_phone_number, phone_number),
        disability_certificate_number = COALESCE(p_disability_certificate_number, disability_certificate_number),
        pension_certificate_number = COALESCE(p_pension_certificate_number, pension_certificate_number)
    WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_affected;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Buyer_Delete(IN p_id INT)
BEGIN
    DELETE FROM buyer WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_deleted;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE Country_Insert(IN p_name VARCHAR(45))
BEGIN
    INSERT INTO country (name) VALUES (p_name);
    SELECT LAST_INSERT_ID() AS new_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Country_Update(IN p_id INT, IN p_name VARCHAR(45))
BEGIN
    UPDATE country 
    SET name = COALESCE(p_name, name)
    WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_affected;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Country_Delete(IN p_id INT)
BEGIN
    DELETE FROM country WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_deleted;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE Brand_Insert(IN p_title VARCHAR(45))
BEGIN
    INSERT INTO brand (title) VALUES (p_title);
    SELECT LAST_INSERT_ID() AS new_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Brand_Update(IN p_id INT, IN p_title VARCHAR(45))
BEGIN
    UPDATE brand 
    SET title = COALESCE(p_title, title)
    WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_affected;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Brand_Delete(IN p_id INT)
BEGIN
    DELETE FROM brand WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_deleted;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE Order_Insert(
    IN p_individual_number VARCHAR(45),
    IN p_date_and_time_formation DATETIME,
    IN p_total_cost DECIMAL,
    IN p_discount DECIMAL,
    IN p_order_status INT,
    IN p_benefits BOOLEAN,
    IN p_buyer_id INT,
    IN p_seller_id INT
)
BEGIN
    INSERT INTO orders 
        (individual_number, date_and_time_formation, total_cost, discount, order_status, benefits, buyer_id, seller_id) 
    VALUES 
        (p_individual_number, p_date_and_time_formation, p_total_cost, p_discount, p_order_status, p_benefits, p_buyer_id, p_seller_id);
    SELECT LAST_INSERT_ID() AS new_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Order_Update(
    IN p_id INT,
    IN p_individual_number VARCHAR(45),
    IN p_date_and_time_formation DATETIME,
    IN p_total_cost DECIMAL,
    IN p_discount DECIMAL,
    IN p_order_status INT,
    IN p_benefits BOOLEAN,
    IN p_buyer_id INT,
    IN p_seller_id INT
)
BEGIN
    UPDATE orders 
    SET 
        individual_number = COALESCE(p_individual_number, individual_number),
        date_and_time_formation = COALESCE(p_date_and_time_formation, date_and_time_formation),
        total_cost = COALESCE(p_total_cost, total_cost),
        discount = COALESCE(p_discount, discount),
        order_status = COALESCE(p_order_status, order_status),
        benefits = COALESCE(p_benefits, benefits),
        buyer_id = COALESCE(p_buyer_id, buyer_id),
        seller_id = COALESCE(p_seller_id, seller_id)
    WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_affected;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Order_Delete(IN p_id INT)
BEGIN
    DELETE FROM orders WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_deleted;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE Supply_agreement_Insert(
    IN p_quantity INT,
    IN p_supplier_id INT,
    IN p_pharmacy_points_id INT,
    IN p_date_formation DATE,
    IN p_date_dispatch DATE,
    IN p_seller_id INT,
    IN p_total_cost DECIMAL,
    IN p_contract_number VARCHAR(45)
)
BEGIN
    INSERT INTO supply_agreement 
        (quantity, supplier_id, pharmacy_points_id, date_formation, date_dispatch, seller_id, total_cost, contract_number) 
    VALUES 
        (p_quantity, p_supplier_id, p_pharmacy_points_id, p_date_formation, p_date_dispatch, p_seller_id, p_total_cost, p_contract_number);
    SELECT LAST_INSERT_ID() AS new_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Supply_agreement_Update(
    IN p_id INT,
    IN p_quantity INT,
    IN p_supplier_id INT,
    IN p_pharmacy_points_id INT,
    IN p_date_formation DATE,
    IN p_date_dispatch DATE,
    IN p_seller_id INT,
    IN p_total_cost DECIMAL,
    IN p_contract_number VARCHAR(45)
)
BEGIN
    UPDATE supply_agreement 
    SET 
        quantity = COALESCE(p_quantity, quantity),
        supplier_id = COALESCE(p_supplier_id, supplier_id),
        pharmacy_points_id = COALESCE(p_pharmacy_points_id, pharmacy_points_id),
        date_formation = COALESCE(p_date_formation, date_formation),
        date_dispatch = COALESCE(p_date_dispatch, date_dispatch),
        seller_id = COALESCE(p_seller_id, seller_id),
        total_cost = COALESCE(p_total_cost, total_cost),
        contract_number = COALESCE(p_contract_number, contract_number)
    WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_affected;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Supply_agreement_Delete(IN p_id INT)
BEGIN
    DELETE FROM supply_agreement WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_deleted;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE Manufacturer_Insert(
    IN p_country_id INT,
    IN p_brand_id INT,
    IN p_title VARCHAR(45)
)
BEGIN
    INSERT INTO manufacturer (country_id, brand_id, title) 
    VALUES (p_country_id, p_brand_id, p_title);
    SELECT LAST_INSERT_ID() AS new_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Manufacturer_Update(
    IN p_id INT,
    IN p_country_id INT,
    IN p_brand_id INT,
    IN p_title VARCHAR(45)
)
BEGIN
    UPDATE manufacturer 
    SET 
        country_id = COALESCE(p_country_id, country_id),
        brand_id = COALESCE(p_brand_id, brand_id),
        title = COALESCE(p_title, title)
    WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_affected;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Manufacturer_Delete(IN p_id INT)
BEGIN
    DELETE FROM manufacturer WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_deleted;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE Goods_Insert(
    IN p_article_number VARCHAR(45),
    IN p_title VARCHAR(45),
    IN p_structure VARCHAR(45),
    IN p_simptom VARCHAR(45),
    IN p_indication VARCHAR(45),
    IN p_quantity INT,
    IN p_method_application VARCHAR(45),
    IN p_contraindication VARCHAR(45),
    IN p_manufacturer_id INT
)
BEGIN
    INSERT INTO goods 
        (article_number, title, structure, simptom, indication, quantity, method_application, contraindication, manufacturer_id) 
    VALUES 
        (p_article_number, p_title, p_structure, p_simptom, p_indication, p_quantity, p_method_application, p_contraindication, p_manufacturer_id);
    SELECT LAST_INSERT_ID() AS new_id;
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE Goods_Update(
    IN p_id INT,
    IN p_article_number VARCHAR(45),
    IN p_title VARCHAR(45),
    IN p_structure VARCHAR(45),
    IN p_simptom VARCHAR(45),
    IN p_quantity INT,
    IN p_method_application VARCHAR(45),
    IN p_contraindication VARCHAR(45),
    IN p_manufacturer_id INT
)
BEGIN
    UPDATE goods 
    SET 
        article_number = COALESCE(p_article_number, article_number),
        title = COALESCE(p_title, title),
        structure = COALESCE(p_structure, structure),
        simptom = COALESCE(p_simptom, simptom),
        quantity = COALESCE(p_quantity, quantity),
        method_application = COALESCE(p_method_application, method_application),
        contraindication = COALESCE(p_contraindication, contraindication),
        manufacturer_id = COALESCE(p_manufacturer_id, manufacturer_id)
    WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_affected;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Goods_Delete(IN p_id INT)
BEGIN
    DELETE FROM goods WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_deleted;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE Supply_agreement_Goods_Insert(
    IN p_supply_agreement_id INT,
    IN p_goods_id INT,
    IN p_quantity INT,
    IN p_price_goods DECIMAL
)
BEGIN
    INSERT INTO supply_agreement_goods (supply_agreement_id, goods_id, quantity, price_goods) 
    VALUES (p_supply_agreement_id, p_goods_id, p_quantity, p_price_goods);
    SELECT ROW_COUNT() AS rows_affected;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Supply_agreement_Goods_Update(
    IN p_supply_agreement_id INT,
    IN p_goods_id INT,
    IN p_quantity INT,
    IN p_price_goods DECIMAL
)
BEGIN
    UPDATE supply_agreement_goods 
    SET 
        quantity = COALESCE(p_quantity, quantity),
        price_goods = COALESCE(p_price_goods, price_goods)
    WHERE supply_agreement_id = p_supply_agreement_id AND goods_id = p_goods_id;
    SELECT ROW_COUNT() AS rows_affected;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Supply_agreement_Goods_Delete(
    IN p_supply_agreement_id INT,
    IN p_goods_id INT
)
BEGIN
    DELETE FROM supply_agreement_goods 
    WHERE supply_agreement_id = p_supply_agreement_id AND goods_id = p_goods_id;
    SELECT ROW_COUNT() AS rows_deleted;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE Receipts_Goods_Insert(
    IN p_fiscal_receipt_id INT,
    IN p_goods_id INT
)
BEGIN
    INSERT INTO receipts_goods (fiscal_receipt_id, goods_id) 
    VALUES (p_fiscal_receipt_id, p_goods_id);
    SELECT LAST_INSERT_ID() AS new_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Receipts_Goods_Update(
    IN p_id INT,
    IN p_fiscal_receipt_id INT,
    IN p_goods_id INT
)
BEGIN
    UPDATE receipts_goods 
    SET 
        fiscal_receipt_id = COALESCE(p_fiscal_receipt_id, fiscal_receipt_id),
        goods_id = COALESCE(p_goods_id, goods_id)
    WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_affected;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Receipts_Goods_Delete(IN p_id INT)
BEGIN
    DELETE FROM receipts_goods WHERE id = p_id;
    SELECT ROW_COUNT() AS rows_deleted;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE Pharmacies_Goods_Insert(
    IN p_pharmacy_points_id INT,
    IN p_goods_id INT
)
BEGIN
    INSERT INTO pharmacies_goods (pharmacy_points_id, goods_id) 
    VALUES (p_pharmacy_points_id, p_goods_id);
    SELECT ROW_COUNT() AS rows_affected;
END //
DELIMITER ;

DELIMITER //

CREATE PROCEDURE Pharmacies_Goods_Update(
    IN p_old_pharmacy_points_id INT,
    IN p_old_goods_id INT,
    IN p_new_pharmacy_points_id INT,
    IN p_new_goods_id INT
)
BEGIN
    UPDATE pharmacies_goods 
    SET 
        pharmacy_points_id = COALESCE(p_new_pharmacy_points_id, pharmacy_points_id),
        goods_id = COALESCE(p_new_goods_id, goods_id)
    WHERE pharmacy_points_id = p_old_pharmacy_points_id 
      AND goods_id = p_old_goods_id;
    
    SELECT ROW_COUNT() AS rows_affected;
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE Pharmacies_Goods_Delete(
    IN p_pharmacy_points_id INT,
    IN p_goods_id INT
)
BEGIN
    DELETE FROM pharmacies_goods 
    WHERE pharmacy_points_id = p_pharmacy_points_id AND goods_id = p_goods_id;
    SELECT ROW_COUNT() AS rows_deleted;
END //

DELIMITER ;

-- ПРАВА ДЛЯ РОЛИ rl_administrator (ВСЕ ПРОЦЕДУРЫ)
SET @grant_admin_procedures = '
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Pharmacy_point_Insert TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Pharmacy_point_Update TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Pharmacy_point_Delete TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Seller_Insert TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Seller_Update TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Seller_Delete TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Fiscal_receipt_Insert TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Fiscal_receipt_Update TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Fiscal_receipt_Delete TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Supplier_Insert TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Supplier_Update TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Supplier_Delete TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Buyer_Insert TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Buyer_Update TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Buyer_Delete TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Country_Insert TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Country_Update TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Country_Delete TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Brand_Insert TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Brand_Update TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Brand_Delete TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Order_Insert TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Order_Update TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Order_Delete TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Supply_agreement_Insert TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Supply_agreement_Update TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Supply_agreement_Delete TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Manufacturer_Insert TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Manufacturer_Update TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Manufacturer_Delete TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Goods_Insert TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Goods_Update TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Goods_Delete TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Supply_agreement_Goods_Insert TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Supply_agreement_Goods_Update TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Supply_agreement_Goods_Delete TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Receipts_Goods_Insert TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Receipts_Goods_Update TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Receipts_Goods_Delete TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Pharmacies_Goods_Insert TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Pharmacies_Goods_Update TO "administrator"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Pharmacies_Goods_Delete TO "administrator"@"localhost";
';

PREPARE stmt_admin_proc FROM @grant_admin_procedures;
EXECUTE stmt_admin_proc;
DEALLOCATE PREPARE stmt_admin_proc;

-- ПРАВА ДЛЯ РОЛИ rl_pharmacist
SET @grant_pharmacist_procedures = '
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Seller_Update TO "pharmacist"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Fiscal_receipt_Insert TO "pharmacist"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Fiscal_receipt_Update TO "pharmacist"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Buyer_Insert TO "pharmacist"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Buyer_Update TO "pharmacist"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Order_Insert TO "pharmacist"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Order_Update TO "pharmacist"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Goods_Update TO "pharmacist"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Receipts_Goods_Insert TO "pharmacist"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.sp_insert_pharmaPharmacies_Goods_Insertcies_goods TO "pharmacist"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Pharmacies_Goods_Delete TO "pharmacist"@"localhost";
';

PREPARE stmt_pharmacist_proc FROM @grant_pharmacist_procedures;
EXECUTE stmt_pharmacist_proc;
DEALLOCATE PREPARE stmt_pharmacist_proc;

-- ПРАВА ДЛЯ РОЛИ rl_supplier
SET @grant_supplier_procedures = '
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Supplier_Insert TO "supplier"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Supplier_Update TO "supplier"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Supply_agreement_Insert TO "supplier"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Supply_agreement_Update TO "supplier"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Supply_agreement_goods_Insert TO "supplier"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Supply_agreement_goods_Update TO "supplier"@"localhost";
';

PREPARE stmt_supplier_proc FROM @grant_supplier_procedures;
EXECUTE stmt_supplier_proc;
DEALLOCATE PREPARE stmt_supplier_proc;

-- ПРАВА ДЛЯ РОЛИ rl_manufacturer
SET @grant_manufacturer_procedures = '
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Brand_Insert TO "manufacturer"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Brand_Update TO "manufacturer"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Manufacturer_Insert TO "manufacturer"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Manufacturer_Update TO "manufacturer"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Goods_Insert TO "manufacturer"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Goods_Update TO "manufacturer"@"localhost";
';

PREPARE stmt_manufacturer_proc FROM @grant_manufacturer_procedures;
EXECUTE stmt_manufacturer_proc;
DEALLOCATE PREPARE stmt_manufacturer_proc;

-- ПРАВА ДЛЯ РОЛИ rl_client
SET @grant_client_procedures = '
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Buyer_Insert TO "rl_client"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Buyer_Update TO "rl_client"@"localhost";
GRANT EXECUTE ON PROCEDURE `9.24.3variant8_2semestr`.Order_Insert TO "rl_client"@"localhost";
';

PREPARE stmt_client_proc FROM @grant_client_procedures;
EXECUTE stmt_client_proc;
DEALLOCATE PREPARE stmt_client_proc;

-- Применение всех прав
FLUSH PRIVILEGES;

SELECT 'Права на процедуры успешно выданы всем ролям' AS result;

INSERT INTO `pharmacy_points` (`title`) VALUES ("АП-001");
CALL Pharmacy_points_Insert("АП-002");

INSERT INTO `goods` (`article_number`, `title`, `structure`, `simptom`, `quantity`,  
`method_application`, `contraindication`, `indication`) VALUES 
("ЛП-0000001", "Авапасипам", "Натуральные цитрусовые и травяные компоненты, натуральная оболочка", 
"-", "0", "От боли в суставах",
"Аллергия на витамин С",
 "Острая или тянущая боль в областях локтей"), 
 ("ЛП-0000002", "Фротувазол", "Витаминный комплекс, растительный состав", "-", "0", 
 "От головной и прочей боли", "Не переносимость гамма элементов",
 "Пульсирующая боль в височной области"), ("ЛП-0000003", "Валокардолин",
 "Биологические элементы, пищевая оболочка", "-", "0", "Профилактика ОРВИ", "Сердечная слабость",
 "Кашель, сонливость, выделения из носовой полости");
 
 INSERT INTO `manufacturer` (`title`) VALUES
 ("ФормаПрод"), ("ГенИнжен");
 
 INSERT INTO `country` (`name`) VALUES ("Россия"), ("Германия");
 
 CALL Country_Insert ("США");
 
INSERT INTO `brand` (`title`) VALUES ("Биокад"), ("Фармстандарт");
 
 CALL Brand_Insert("Отисифарм");
 
 CALL Manufacturer_Insert("3", "3", "ХиллОлл");
 
 
 CALL Goods_Insert("ЛП-0000004", "Редрогедоран", "Натуральные жиры и масла", "-",
"Растяжения, ушибы, подтёки", "0", "От мышечной боли", 
"Почечная недостаточность", 1);
 CALL Goods_Insert("ЛП-0000005", "Рамеростам", "Бифитобактерии, микроэлементы", "-", "Заложенность носа, покраснения", "0", 
 "Профилактика аллергии", "Расстройство желудка", 2);
 CALL Goods_Insert("ЛП-0000006", "Картитозанол",
 "Ферменты масел, ферменты микроэлементов", "-", "Отёк конечностей", "0", "Снятие отёков", "Непереносимость глюкозы", 3);
 CALL Goods_Insert("ЛП-0000007", "Флютозипам",
 "Натуральные масла", "-", "Тянущая и ноющая боль в сгибах конечностей", "0", 
 "От мышечного растяжения", "Аллергия на травы", 3);

