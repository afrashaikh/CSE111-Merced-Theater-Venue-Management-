-- ============================================================================
-- CSE 111 Fall 2026: Checkpoint 2 -- Abaigael Savio's portion (STANDALONE)
-- Project: Merced Theater Venue Management
-- Tables: VenueOwners, Venues, EventManagers, Events, TicketTypes
-- Statements: 01-05, 11-15, 21, 22-26, 31
--
-- This file runs by itself on an EMPTY database and uses only the five tables
-- above:   sqlite3 dev.sqlite3 < Abaigael_part.sql
-- Afra's file (Afra_part.sql) is run AFTER this one and builds on it.
-- ============================================================================

PRAGMA foreign_keys = ON;
.headers on
.mode column

-- ============================================================================
-- PART 1: SCHEMA (Checkpoint 1 tables for this portion)
-- ============================================================================

CREATE TABLE VenueOwners (
    owner_id INTEGER PRIMARY KEY,
    owner_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20)
);

CREATE TABLE Venues (
    venue_id INTEGER PRIMARY KEY,
    venue_name VARCHAR(100) NOT NULL,
    capacity INTEGER NOT NULL CHECK (capacity > 0),
    rental_fee DECIMAL(10,2) NOT NULL CHECK (rental_fee >= 0.0),
    owner_id INTEGER NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES VenueOwners(owner_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE EventManagers (
    manager_id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20)
);

CREATE TABLE Events (
    event_id INTEGER PRIMARY KEY,
    event_name VARCHAR(150) NOT NULL,
    event_date DATETIME NOT NULL,
    venue_id INTEGER NOT NULL,
    manager_id INTEGER NOT NULL,
    rebooked_from_event_id INTEGER,
    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (manager_id) REFERENCES EventManagers(manager_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (rebooked_from_event_id) REFERENCES Events(event_id)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE TicketTypes (
    ticket_type_id INTEGER PRIMARY KEY,
    event_id INTEGER NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0.0),
    qty_available INTEGER NOT NULL CHECK (qty_available >= 0),
    UNIQUE (event_id, category),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- ============================================================================
-- PART 2: SEED DATA
-- ============================================================================

INSERT INTO VenueOwners (owner_id, owner_name, email, phone) VALUES
    (1, 'Merced Arts Council', 'info@mercedarts.example', '209-555-0101'),
    (2, 'Valley Holdings LLC', 'contact@valleyholdings.example', '209-555-0102'),
    (3, 'Sierra Cultural Trust', 'office@sierratrust.example', '209-555-0103'),
    (4, 'Delta Properties', 'hello@deltaprops.example', NULL);

INSERT INTO Venues (venue_id, venue_name, capacity, rental_fee, owner_id) VALUES
    (1, 'Merced Theatre Main Hall', 600, 2500, 1),
    (2, 'Merced Theatre Black Box', 120, 800, 1),
    (3, 'Valley Amphitheater', 1500, 5000, 2),
    (4, 'Sierra Hall', 300, 1200, 3),
    (5, 'Courtyard Stage', 200, 600, 3);

INSERT INTO EventManagers (manager_id, name, email, phone) VALUES
    (1, 'Maria Lopez', 'maria.lopez@mercedtheater.example', '209-555-0111'),
    (2, 'James Chen', 'james.chen@mercedtheater.example', '209-555-0112'),
    (3, 'Priya Patel', 'priya.patel@mercedtheater.example', NULL);

INSERT INTO Events (event_id, event_name, event_date, venue_id, manager_id, rebooked_from_event_id) VALUES
    (1, 'Spring Jazz Night', '2026-03-14 19:00:00', 1, 1, NULL),
    (2, 'Spring Jazz Night Encore', '2026-04-18 19:00:00', 1, 1, 1),
    (3, 'Spring Jazz Night Encore II', '2026-05-23 19:00:00', 2, 1, 2),
    (4, 'Valley Rock Fest', '2026-06-06 16:00:00', 3, 2, NULL),
    (5, 'Local Comedy Showcase', '2026-07-11 20:00:00', 2, 3, NULL),
    (6, 'Folk Under the Stars', '2026-08-15 18:30:00', 3, 2, NULL),
    (7, 'Holiday Choir Concert', '2026-12-12 18:00:00', 1, 3, NULL),
    (8, 'Winter Comedy Night', '2026-12-19 20:00:00', 2, 3, 5),
    (9, 'New Year''s Eve Gala', '2026-12-31 21:00:00', 1, 1, NULL),
    (10, 'Indie Showcase', '2026-11-21 19:00:00', 4, 2, NULL),
    (11, 'Acoustic Evening', '2026-10-10 19:30:00', 4, 2, NULL),
    (12, 'Community Open Mic', '2027-01-16 18:00:00', 2, 3, NULL);

INSERT INTO TicketTypes (ticket_type_id, event_id, category, price, qty_available) VALUES
    (1, 1, 'General', 25, 40),
    (2, 1, 'VIP', 60, 3),
    (3, 2, 'General', 28, 80),
    (4, 2, 'VIP', 65, 10),
    (5, 3, 'General', 30, 60),
    (6, 3, 'VIP', 70, 5),
    (7, 4, 'General', 45, 500),
    (8, 4, 'VIP', 120, 40),
    (9, 4, 'Student', 25, 100),
    (10, 5, 'General', 20, 40),
    (11, 5, 'Student', 12, 4),
    (12, 6, 'General', 35, 400),
    (13, 6, 'VIP', 90, 25),
    (14, 7, 'General', 18, 200),
    (15, 7, 'Student', 10, 60),
    (16, 7, 'VIP', 45, 15),
    (17, 8, 'General', 22, 5),
    (18, 8, 'VIP', 55, 3),
    (19, 9, 'General', 75, 250),
    (20, 9, 'VIP', 150, 30),
    (21, 10, 'General', 30, 150),
    (22, 10, 'Student', 15, 4),
    (23, 11, 'General', 22, 100);

-- ============================================================================
-- PART 3: SQL STATEMENTS
-- ============================================================================

-- ############ SIMPLE STATEMENTS ############

-- ----------------------------------------------------------------------------
-- Statement 01: Large venues
-- Explanation: Lists every venue that can hold at least 300 people, with the
--              largest venues first.
-- ----------------------------------------------------------------------------
SELECT venue_name, capacity, rental_fee
FROM Venues
WHERE capacity >= 300
ORDER BY capacity DESC;

-- ----------------------------------------------------------------------------
-- Statement 02: Comedy events (pattern matching)
-- Explanation: Finds all events whose name contains the word "Comedy" using
--              LIKE, ordered by date.
-- ----------------------------------------------------------------------------
SELECT event_id, event_name, event_date
FROM Events
WHERE event_name LIKE '%Comedy%'
ORDER BY event_date;

-- ----------------------------------------------------------------------------
-- Statement 03: Total number of events
-- Explanation: Counts all events in the system with a scalar aggregate.
-- ----------------------------------------------------------------------------
SELECT COUNT(*) AS total_events
FROM Events;

-- ----------------------------------------------------------------------------
-- Statement 04: Add a new event manager (INSERT)
-- Explanation: Inserts a new event manager who has not been assigned to any
--              events yet.
-- ----------------------------------------------------------------------------
INSERT INTO EventManagers (manager_id, name, email, phone)
VALUES (4, 'Noor Rahman', 'noor.rahman@mercedtheater.example', '209-555-0144');

-- ----------------------------------------------------------------------------
-- Statement 05: Update a venue rental fee (UPDATE)
-- Explanation: Raises the rental fee of the Courtyard Stage (venue 5) to 650.
-- ----------------------------------------------------------------------------
UPDATE Venues
SET rental_fee = 650.00
WHERE venue_id = 5;

-- ############ INTERMEDIATE STATEMENTS ############

-- ----------------------------------------------------------------------------
-- Statement 11: Events with venue and manager
-- Explanation: Joins Events, Venues, and EventManagers to list each event
--              with where it is held and who manages it.
-- ----------------------------------------------------------------------------
SELECT e.event_name, e.event_date, v.venue_name, m.name AS manager
FROM Events e
JOIN Venues v ON e.venue_id = v.venue_id
JOIN EventManagers m ON e.manager_id = m.manager_id
ORDER BY e.event_date;

-- ----------------------------------------------------------------------------
-- Statement 12: Owners with multiple venues
-- Explanation: Groups venues by owner and keeps only owners with at least two
--              venues, showing the venue count and combined capacity.
-- ----------------------------------------------------------------------------
SELECT o.owner_name,
       COUNT(*) AS venue_count,
       SUM(v.capacity) AS total_capacity
FROM VenueOwners o
JOIN Venues v ON v.owner_id = o.owner_id
GROUP BY o.owner_id, o.owner_name
HAVING COUNT(*) >= 2
ORDER BY total_capacity DESC;

-- ----------------------------------------------------------------------------
-- Statement 13: Events with no ticket types
-- Explanation: Uses a LEFT JOIN from Events to TicketTypes and keeps events
--              with no matching ticket type, i.e. events not yet on sale.
-- ----------------------------------------------------------------------------
SELECT e.event_id, e.event_name, e.event_date
FROM Events e
LEFT JOIN TicketTypes tt ON tt.event_id = e.event_id
WHERE tt.ticket_type_id IS NULL;

-- ----------------------------------------------------------------------------
-- Statement 14: Tickets still available per event
-- Explanation: Sums the remaining ticket quantity across all ticket types of
--              each event, showing events with the most availability first.
-- ----------------------------------------------------------------------------
SELECT e.event_name,
       COUNT(tt.ticket_type_id) AS ticket_types,
       SUM(tt.qty_available) AS tickets_remaining
FROM Events e
JOIN TicketTypes tt ON tt.event_id = e.event_id
GROUP BY e.event_id, e.event_name
ORDER BY tickets_remaining DESC;

-- ----------------------------------------------------------------------------
-- Statement 15: Raise prices on nearly sold-out upcoming tickets
-- Explanation: Conditionally increases the price by 10% for ticket types with
--              5 or fewer tickets left, for events after 2026-11-16 only.
-- ----------------------------------------------------------------------------
UPDATE TicketTypes
SET price = ROUND(price * 1.10, 2)
WHERE qty_available <= 5
  AND event_id IN (SELECT event_id
                   FROM Events
                   WHERE event_date > '2026-11-16');

-- ----------------------------------------------------------------------------
-- Statement 21: Venues pricier than average (scalar subquery)
-- Explanation: Returns venues whose rental fee is above the average rental
--              fee of all venues, computed with a scalar subquery.
-- ----------------------------------------------------------------------------
SELECT venue_name, rental_fee
FROM Venues
WHERE rental_fee > (SELECT AVG(rental_fee) FROM Venues)
ORDER BY rental_fee DESC;

-- ############ COMPLEX STATEMENTS ############

-- ----------------------------------------------------------------------------
-- Statement 22: Events with above-average unsold ticket value (CTE)
-- Explanation: A CTE totals the value of unsold tickets (price x qty_available) per event, then the main query returns events above the average.
-- ----------------------------------------------------------------------------
WITH inventory AS (
    SELECT event_id,
           SUM(price * qty_available) AS unsold_value
    FROM TicketTypes
    GROUP BY event_id
)
SELECT e.event_name, i.unsold_value
FROM inventory i
JOIN Events e ON e.event_id = i.event_id
WHERE i.unsold_value > (SELECT AVG(unsold_value) FROM inventory)
ORDER BY i.unsold_value DESC;

-- ----------------------------------------------------------------------------
-- Statement 23: Rebooking chain (recursive CTE)
-- Explanation: Starting from event 1, a recursive CTE follows the
--              rebooked_from_event_id link to list every later rebooking.
-- ----------------------------------------------------------------------------
WITH RECURSIVE rebooking_chain(event_id, event_name, event_date, depth) AS (
    SELECT event_id, event_name, event_date, 0
    FROM Events
    WHERE event_id = 1
    UNION ALL
    SELECT e.event_id, e.event_name, e.event_date, rc.depth + 1
    FROM Events e
    JOIN rebooking_chain rc ON e.rebooked_from_event_id = rc.event_id
)
SELECT depth, event_id, event_name, event_date
FROM rebooking_chain
ORDER BY depth;

-- ----------------------------------------------------------------------------
-- Statement 24: Venues with no events (NOT EXISTS)
-- Explanation: Uses a correlated NOT EXISTS subquery to find venues that
--              have never hosted or been booked for an event.
-- ----------------------------------------------------------------------------
SELECT v.venue_id, v.venue_name, v.capacity
FROM Venues v
WHERE NOT EXISTS (SELECT 1
                  FROM Events e
                  WHERE e.venue_id = v.venue_id);

-- ----------------------------------------------------------------------------
-- Statement 25: Event summary view (CREATE VIEW)
-- Explanation: Creates the EventFinancials view summarizing each event's venue, manager, remaining tickets, unsold ticket value, and venue cost, then queries it. (Afra's portion later extends this view with sales revenue and performer costs.)
-- ----------------------------------------------------------------------------
DROP VIEW IF EXISTS EventFinancials;

CREATE VIEW EventFinancials AS
SELECT e.event_id,
       e.event_name,
       e.event_date,
       v.venue_name,
       m.name AS manager_name,
       COUNT(tt.ticket_type_id) AS ticket_types,
       COALESCE(SUM(tt.qty_available), 0) AS tickets_remaining,
       COALESCE(SUM(tt.price * tt.qty_available), 0) AS unsold_value,
       v.rental_fee AS venue_cost
FROM Events e
JOIN Venues v ON e.venue_id = v.venue_id
JOIN EventManagers m ON e.manager_id = m.manager_id
LEFT JOIN TicketTypes tt ON tt.event_id = e.event_id
GROUP BY e.event_id, e.event_name, e.event_date, v.venue_name, m.name, v.rental_fee;

SELECT event_name, venue_name, tickets_remaining, unsold_value, venue_cost
FROM EventFinancials
ORDER BY unsold_value DESC;

-- ----------------------------------------------------------------------------
-- Statement 26: Ticket availability labels (CASE)
-- Explanation: Uses a CASE expression to label each event by how many tickets
--              remain; events with no ticket types are labeled separately.
-- ----------------------------------------------------------------------------
SELECT e.event_name,
       COALESCE(SUM(tt.qty_available), 0) AS tickets_remaining,
       CASE
           WHEN COUNT(tt.ticket_type_id) = 0 THEN 'No Tickets Created'
           WHEN SUM(tt.qty_available) = 0 THEN 'Sold Out'
           WHEN SUM(tt.qty_available) <= 10 THEN 'Almost Sold Out'
           WHEN SUM(tt.qty_available) <= 100 THEN 'Selling'
           ELSE 'Plenty Available'
       END AS availability
FROM Events e
LEFT JOIN TicketTypes tt ON tt.event_id = e.event_id
GROUP BY e.event_id, e.event_name
ORDER BY tickets_remaining;

-- ----------------------------------------------------------------------------
-- Statement 31: Trigger that copies ticket types when an event is rebooked
-- Explanation: After an event is inserted with a rebooked_from_event_id, the trigger copies the original event's ticket categories, prices, and quantities to the new event. A demo rebooking is inserted, checked, and then removed.
-- ----------------------------------------------------------------------------
DROP TRIGGER IF EXISTS trg_events_after_rebook;

CREATE TRIGGER trg_events_after_rebook
AFTER INSERT ON Events
WHEN NEW.rebooked_from_event_id IS NOT NULL
BEGIN
    INSERT INTO TicketTypes (event_id, category, price, qty_available)
    SELECT NEW.event_id, category, price, qty_available
    FROM TicketTypes
    WHERE event_id = NEW.rebooked_from_event_id;
END;

-- Demo: rebook event 5 (Local Comedy Showcase) as new event 13.
INSERT INTO Events (event_id, event_name, event_date, venue_id, manager_id, rebooked_from_event_id)
VALUES (13, 'Local Comedy Showcase Encore', '2027-02-20 20:00:00', 2, 3, 5);

-- Verify: event 13 should now have the same ticket categories as event 5.
SELECT e.event_name, tt.category, tt.price, tt.qty_available
FROM Events e
JOIN TicketTypes tt ON tt.event_id = e.event_id
WHERE e.event_id = 13;

-- Clean up the demo event (its ticket types are removed by ON DELETE CASCADE).
DELETE FROM Events
WHERE event_id = 13;