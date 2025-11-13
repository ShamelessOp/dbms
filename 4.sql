DELIMITER //

CREATE DATABASE p4;
USE p4//

    CREATE TABLE IF NOT EXISTS Borrower (
        Roll_no INT PRIMARY KEY,
        Name VARCHAR(100),
        DateofIssue DATE,
        NameofBook VARCHAR(100),
        Status ENUM('issued', 'returned')
    )//

    CREATE TABLE IF NOT EXISTS Fine (
        Roll_no INT,
        Fine_Date DATE,
        Amt DECIMAL(10, 2),
        PRIMARY KEY (Roll_no, Fine_Date)
    )//

    INSERT INTO Borrower (Roll_no, Name, DateofIssue, NameofBook, Status) VALUES
    (12, 'patel', '2018-07-01', 'xyz', 'issued'),
    (14, 'shinde', '2018-06-01', 'oop', 'issued'),
    (16, 'bhangale', '2018-05-01', 'coa', 'returned'),
    (18, 'rebello', '2018-06-15', 'toc', 'returned'),
    (20, 'patil', '2018-05-15', 'mp', 'issued')//

    DROP PROCEDURE IF EXISTS calculate_and_update_fine//
    CREATE PROCEDURE calculate_and_update_fine(
        IN p_roll_no INT, 
        IN p_book_name VARCHAR(100)
    )
    BEGIN
        DECLARE v_days_issued INT DEFAULT 0;
        
        DECLARE CONTINUE HANDLER FOR NOT FOUND
        BEGIN
            SELECT 'NOT FOUND' AS Message;
        END;

        SELECT DATEDIFF(CURDATE(), DateofIssue) 
        INTO v_days_issued 
        FROM Borrower
        WHERE Roll_no = p_roll_no AND NameofBook = p_book_name AND Status = 'issued';

        IF v_days_issued > 0 THEN 
            
            IF (v_days_issued > 15 AND v_days_issued < 30) THEN
                INSERT INTO Fine (Roll_no, Fine_Date, Amt) 
                VALUES (p_roll_no, CURDATE(), v_days_issued * 5);
            
            ELSEIF v_days_issued > 30 THEN
                INSERT INTO Fine (Roll_no, Fine_Date, Amt) 
                VALUES (p_roll_no, CURDATE(), v_days_issued * 50);
            
            END IF;

            UPDATE Borrower 
            SET Status = 'returned' 
            WHERE Roll_no = p_roll_no;
            
        END IF;

        SELECT 'Query OK, 1 row affected' AS Result;

    END//

    DELIMITER ;

    CALL calculate_and_update_fine(12, 'xyz');

    CALL calculate_and_update_fine(20, 'mp');

    SELECT * FROM Fine;

    SELECT * FROM Borrower;

    CALL calculate_and_update_fine(99, 'nonexistent');
