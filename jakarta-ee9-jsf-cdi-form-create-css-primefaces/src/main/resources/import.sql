CREATE TABLE `product_test` (
                                `id` int NOT NULL AUTO_INCREMENT,
                                `name` varchar(30) DEFAULT NULL,
                                `price` float DEFAULT NULL,
                                `date` date DEFAULT NULL,
                                `sku` varchar(10) DEFAULT NULL,
                                PRIMARY KEY (`id`),
                                UNIQUE KEY `sku_unique` (`sku`)
) ENGINE=InnoDB;

INSERT INTO enterprise.product_test (id, name, price, date, sku) VALUES (1, 'TV Samsung TH581', 668.99, '2023-05-28', 'abcde12345');
INSERT INTO enterprise.product_test (id, name, price, date, sku) VALUES (2, 'Raspberry Pi 4 8GB', 89.56, '2023-05-28', 'abcdf12345');
INSERT INTO enterprise.product_test (id, name, price, date, sku) VALUES (3, 'gloves', 12, '2024-10-06', '2345523422');
INSERT INTO enterprise.product_test (id, name, price, date, sku) VALUES (4, 'table tennis', 147, '2024-10-06', '14154123');
INSERT INTO enterprise.product_test (id, name, price, date, sku) VALUES (5, 'socker ball', 34, '2024-11-26',  '39887689');
INSERT INTO enterprise.product_test (id, name, price, date, sku) VALUES (6, 'CPU Intel', 345, '2024-10-12', '23521243');

SELECT * FROM product_test;
