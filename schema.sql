-- movieloans — database schema
-- Run this once against your 'movieloans' database before using the app.

CREATE TABLE IF NOT EXISTS monitors (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    firstname  VARCHAR(50)  NOT NULL,
    lastname   VARCHAR(50)  NOT NULL,
    email      VARCHAR(100) NOT NULL UNIQUE,
    password   VARCHAR(255) NOT NULL   -- a password_hash() hash, never plain text
);

CREATE TABLE IF NOT EXISTS loans (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    film_name      VARCHAR(40)  NOT NULL,
    borrower_name  VARCHAR(20)  NOT NULL,
    borrowed_date  DATE         NOT NULL,
    borrower_email VARCHAR(40)  NOT NULL,
    due_back       DATE         NOT NULL,
    returned_date  DATE         NULL,      -- NULL = still out
    notes          VARCHAR(255) NULL,
    logged_by      INT          NULL,      -- which monitor logged it
    FOREIGN KEY (logged_by) REFERENCES monitors(id)
);

-- Demo monitor account: monitor@school.nz / password123
-- (the hash below is a real bcrypt hash of "password123")
INSERT INTO monitors (firstname, lastname, email, password) VALUES
    ('Oscar', 'McNicholl', 'monitor@email.com', '$2y$10$Ygge3kKa.Sq/GD7/hEj58.RCYfmjNFBbr3.N/16V9TpTh59YFmLHO');

-- A few sample loans so view_loans.php / manage_loans.php show something immediately.
INSERT INTO loans (film_name, borrower_name, borrowed_date, due_back, returned_date, logged_by) VALUES
    ('28 DAYS LATER', 'Jason D.', '2026-07-20', '2026-07-27', NULL,         1),
    ('SHREK 2',  'Farhaan A.',  '2026-07-15', '2026-07-16', NULL,         1), -- deliberately overdue
    ('AVATAR', 'Alex Q.',   '2026-07-18', '2026-07-19', '2026-07-19', 1);
