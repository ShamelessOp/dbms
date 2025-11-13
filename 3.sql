

CREATE TABLE product_master(
    product_no INT PRIMARY KEY, 
    description VARCHAR(20),
    profit_per FLOAT, 
    unit_measure VARCHAR(10), 
    quantity INT, 
    reorder FLOAT,
    cost_price FLOAT, 
    sell_price INT 
);

CREATE TABLE customer(
    cust_no INT PRIMARY KEY,
    cust_name VARCHAR(20),
    cust_add VARCHAR(20),
    phone_no INT
);

CREATE TABLE capital(
    cap_no INT PRIMARY KEY,
    cap_name VARCHAR(20),
    state_no INT
);

CREATE TABLE state(
    state_no INT PRIMARY KEY,
    state_name VARCHAR(20),
    state_code INT,
    capital VARCHAR(20)
);

INSERT INTO capital VALUES(1, 'MH', 1);
INSERT INTO capital VALUES(2, 'RAJ', 2);
INSERT INTO capital VALUES(3, 'GOA', 3);
INSERT INTO capital VALUES(4, 'GUJ', 4);
INSERT INTO capital VALUES(5, 'KAR', 5);

INSERT INTO state VALUES(1, 'MH', 1, 'MUM');
INSERT INTO state VALUES(2, 'RAJ', 2, 'JAI');
INSERT INTO state VALUES(3, 'GOA', 3, 'PAN');
INSERT INTO state VALUES(4, 'GUJ', 4, 'SUR');
INSERT INTO state VALUES(5, 'KAR', 5, 'BAN');

SELECT * FROM capital;
SELECT * FROM state;

SELECT capital.cap_no, state.state_no 
FROM capital 
INNER JOIN state 
ON capital.cap_no = state.state_no;

UPDATE state SET state_no = 78 WHERE state_no = 1;
UPDATE state SET state_no = 58 WHERE state_no = 2;
UPDATE state SET state_no = 46 WHERE state_no = 3;
UPDATE state SET state_no = 489 WHERE state_no = 4;
UPDATE state SET state_no = 458 WHERE state_no = 5;

INSERT INTO state VALUES(5, 'MP', 5, 'BHO');

SELECT capital.cap_no, state.state_no 
FROM capital 
INNER JOIN state 
ON capital.cap_no = state.state_no;

SELECT capital.cap_no, state.state_no 
FROM capital 
LEFT JOIN state 
ON capital.cap_no = state.state_no;

SELECT capital.cap_no, state.state_no 
FROM capital 
LEFT JOIN state 
ON capital.cap_no = state.state_name;

SELECT capital.cap_no, state.state_no 
FROM capital 
RIGHT JOIN state 
ON capital.cap_no = state.state_no;

SELECT capital.cap_no, capital.cap_name, state.capital, state.state_no 
FROM capital 
INNER JOIN state 
ON capital.cap_no = state.state_no;

SELECT capital.cap_no, capital.cap_name, state.capital, state.state_no 
FROM capital 
LEFT JOIN state 
ON capital.cap_no = state.state_no;

SELECT capital.cap_no, capital.cap_name, state.capital, state.state_no 
FROM capital 
RIGHT JOIN state 
ON capital.cap_no = state.state_no;

SELECT capital.cap_no, capital.cap_name, state.capital, state.state_no 
FROM capital 
LEFT JOIN state 
ON capital.cap_no = state.state_no
UNION
SELECT capital.cap_no, capital.cap_name, state.capital, state.state_no 
FROM capital 
RIGHT JOIN state 
ON capital.cap_no = state.state_no;

SELECT * FROM capital c1, state s1 
WHERE c1.cap_no = s1.state_no;

SELECT * FROM capital c1, state s1 
WHERE c1.cap_no != s1.state_no;

SELECT * FROM state 
WHERE state_no = (SELECT state_no FROM state WHERE state_name = 'MH');

SELECT * FROM state 
WHERE state_no = (SELECT state_no FROM state WHERE state_name = 'GUJ');

SELECT * FROM state 
WHERE state_no = (SELECT capital.state_no FROM capital WHERE cap_name = 'MH');

SELECT * FROM state 
WHERE state_no = (SELECT capital.state_no FROM capital WHERE cap_name = 'GUJ');

SELECT * FROM state 
WHERE state_no = (SELECT capital.state_no FROM capital WHERE cap_name = 'RAJ');

SELECT * FROM state 
WHERE state_no = (SELECT capital.state_no FROM capital WHERE cap_name = 'KAR');
