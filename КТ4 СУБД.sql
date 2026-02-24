DELIMITER //

CREATE PROCEDURE CreateTable()
BEGIN

CREATE table IF NOT EXISTS pharmacy_points
(
id INT auto_increment PRIMARY KEY,
title VARCHAR(20) NOT NULL
);

CREATE table IF NOT EXISTS seller
(
id INT auto_increment PRIMARY KEY,
surname VARCHAR(45) NOT NULL,
name VARCHAR(45) NOT NULL,
patronymic VARCHAR(45) NULL,
login VARCHAR(45) NOT NULL,
password VARCHAR(45) NOT NULL
);

CREATE table IF NOT EXISTS fiscal_receipt
(
id INT auto_increment PRIMARY KEY,
formation_at DATETIME NOT NULL,
receipt_number VARCHAR(45) NOT NULL,
discount DECIMAL(10,2) NOT NULL,
total_cost DECIMAL(10,2) NOT NULL,
amount_money_deposited DECIMAL NOT NULL,
benefits BOOLEAN NOT NULL
);

CREATE table IF NOT EXISTS supplier
(
id INT auto_increment PRIMARY KEY,
title VARCHAR(45) NOT NULL,
legal_address VARCHAR(100) NOT NULL,
physical_address VARCHAR(255) NOT NULL,
okpo VARCHAR(45) NOT NULL,
bic VARCHAR(45) NOT NULL,
surname VARCHAR(45) NOT NULL,
name VARCHAR(45) NOT NULL,
patronymic VARCHAR(45) NULL
);

CREATE table IF NOT EXISTS buyer
(
id INT auto_increment PRIMARY KEY,
passport_series VARCHAR(45) NOT NULL,
passport_number VARCHAR(45) NOT NULL,
surname VARCHAR(45) NOT NULL,
name VARCHAR(45) NOT NULL,
patronymic VARCHAR(45) NULL,
CMI VARCHAR(45) NOT NULL,
phone VARCHAR(45) NOT NULL,
disability_certificate VARCHAR(45) NOT NULL,
pension_certificate VARCHAR(45) NOT NULL
);

CREATE table IF NOT EXISTS country
(
id INT auto_increment PRIMARY KEY,
name VARCHAR(45) NOT NULL
);

CREATE table IF NOT EXISTS brand
(
id INT auto_increment PRIMARY KEY,
title VARCHAR(45) NOT NULL
);

CREATE table IF NOT EXISTS orders
(
id INT auto_increment PRIMARY KEY,
individual_number VARCHAR(45) NOT NULL,
formation_at DATETIME NOT NULL,
total_cost DECIMAL(10,2) NOT NULL,
discount DECIMAL(10,2) NOT NULL,
order_status INT NOT NULL,
benefits BOOLEAN NOT NULL,
buyer_id INT REFERENCES buyer(id),
seller_id INT REFERENCES seller(id)
);

CREATE table IF NOT EXISTS supply_agreement
(
id INT auto_increment PRIMARY KEY,
quantity INT NOT NULL,
supplier_id INT REFERENCES supplier(id),
pharmacy_points_id INT REFERENCES pharmacy_points(id),
formation_at DATE NOT NULL,
dispatch_at DATE NOT NULL,
seller_id INT REFERENCES seller(id),
total_cost DECIMAL(10,2) NOT NULL,
contract_number VARCHAR(45) NOT NULL
);

CREATE table IF NOT EXISTS manufacturer
(
id INT auto_increment PRIMARY KEY,
country_id INT REFERENCES country(id),
brand_id INT REFERENCES brand(id),
title VARCHAR(45) NOT NULL
);

CREATE table IF NOT EXISTS goods
(
id INT auto_increment PRIMARY KEY,
article_number VARCHAR(45) NOT NULL,
title VARCHAR(45) NOT NULL,
structure VARCHAR(45) NOT NULL,
simptom VARCHAR(45) NOT NULL,
quantity INT NOT NULL,
method_application VARCHAR(45) NOT NULL,
contraindication VARCHAR(45) NOT NULL,
manufacturer_id INT REFERENCES manufacturer(id)
);

CREATE table IF NOT EXISTS supply_agreement_goods
(
supply_agreement_id INT REFERENCES supply_agreement(id),
goods_id INT REFERENCES goods(id),
quantity INT NOT NULL,
price_goods DECIMAL(10,2) NOT NULL
);

CREATE table IF NOT EXISTS receipts_goods
(
id INT auto_increment PRIMARY KEY,
fiscal_receipt_id INT REFERENCES fiscal_receipt(id),
goods_id INT REFERENCES goods(id)
);

CREATE table IF NOT EXISTS pharmacies_goods
(
pharmacy_points_id INT REFERENCES pharmacy_points(id),
goods_id INT REFERENCES goods(id)
);
END //

DELIMITER ;
CALL CreateTable();
DROP PROCEDURE IF EXISTS CreateTable;

DELIMITER //

DROP PROCEDURE IF EXISTS CreateTable;
CREATE PROCEDURE DropTables()
BEGIN

	SET FOREIGN_KEY_CHECKS = 0;
    
    DROP TABLE IF EXISTS brand;
    DROP TABLE IF EXISTS buyer;
    DROP TABLE IF EXISTS country;
    DROP TABLE IF EXISTS fiscal_receipt;
    DROP TABLE IF EXISTS goods;
    DROP TABLE IF EXISTS manufacturer;
    DROP TABLE IF EXISTS orders;
    DROP TABLE IF EXISTS pharmacies_goods;
    DROP TABLE IF EXISTS pharmacy_points;
    DROP TABLE IF EXISTS receipts_goods;
    DROP TABLE IF EXISTS seller;
    DROP TABLE IF EXISTS supplier;
    DROP TABLE IF EXISTS supply_agreement;
    DROP TABLE IF EXISTS supply_agreement_goods;
    
    SET FOREIGN_KEY_CHECKS = 1;
    
END //

DELIMITER ;
CALL DropTables();

CREATE INDEX idx_phone ON users (номер_телефона);
CREATE INDEX idx_passport_number ON users (номер_паспорта);
CREATE INDEX idx_passport_series ON users (серия_паспорта);

REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'manufacturer'@'localhost';

GRANT ALL PRIVILEGES ON `9.24.3variant8_2semestr`.* TO "administrator"@"localhost";
SHOW GRANTS FOR 'administrator'@'localhost';

GRANT SELECT, INSERT, UPDATE ON supply_agreement TO 'manufacturer'@'localhost';
GRANT INSERT, UPDATE ON supply_agreement_goods TO 'manufacturer'@'localhost';
GRANT SELECT, INSERT, UPDATE ON manufacturer TO 'manufacturer'@'localhost';
GRANT SELECT, INSERT, UPDATE ON goods TO 'manufacturer'@'localhost';
SHOW GRANTS FOR 'manufacturer'@'localhost';

REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'client'@'localhost';
SHOW GRANTS FOR 'client'@'localhost';

REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'pharmacist'@'localhost';
GRANT SELECT ON fiscal_receipt TO 'pharmacist'@'localhost';
GRANT SELECT ON buyer TO 'pharmacist'@'localhost';
GRANT SELECT ON receipts_goods TO 'pharmacist'@'localhost';
SHOW GRANTS FOR 'pharmacist'@'localhost';

REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'supplier'@'localhost';
GRANT SELECT, INSERT, UPDATE ON orders TO 'supplier'@'localhost';
GRANT SELECT, INSERT, UPDATE ON supply_agreement TO 'supplier'@'localhost';
GRANT SELECT ON supplier TO 'supplier'@'localhost';
GRANT SELECT, INSERT, UPDATE ON supply_agreement_goods TO 'supplier'@'localhost';
GRANT SELECT, INSERT, UPDATE ON goods TO 'supplier'@'localhost';
SHOW GRANTS FOR 'supplier'@'localhost';

SELECT VERSION();
