-- ============================================================================
-- CSE 111 Fall 2026: Project Checkpoint 2 Script
-- Project Title: Merced Theater Venue Management
-- Team Members: Abaigael Savio, Afra Shaikh
-- File: Checkpoint2-script.sql
-- ============================================================================

-- ============================================================================
-- SCHEMA MODIFICATIONS SINCE CHECKPOINT 1
-- ============================================================================
-- No modifications made to the Checkpoint 1 tables. Additions and notes:
-- 1. Naming: Performs is the Performances table and Contains is the SaleItems
--    table. customer and total are customer_name and total_amount.
-- 2. Added a view (EventFinancials) and three triggers (trg_events_after_rebook,
--    trg_saleitems_after_insert, trg_saleitems_after_delete).
-- 3. Statements 22 and 25 each have an original and a newer version, so
--    Statements 01 to 32 contain 34 entries.
-- 4. Section 4 adds Statements 33 to 42: the Checkpoint 1 use case (create
--    event and ticket types, book performers, adjust prices, sell tickets,
--    check availability, report) done with INSERT statements. That makes 42
--    numbered statements, or 44 counting the revised versions of 22 and 25.
-- 5. The Checkpoint 1 use cases "Submit Booking Request" and "Approve venue
--    rental" are not modeled, because the schema has no booking-request table.
-- ============================================================================

-- ============================================================================
-- MEMBER CONTRIBUTIONS SUMMARY (GROUPED AT THE TOP)
-- ============================================================================
-- SECTION 1: SIMPLE STATEMENTS
-- Statement 01: Abaigael Savio: 70%, Afra Shaikh: 30%
-- Statement 02: Abaigael Savio: 70%, Afra Shaikh: 30%
-- Statement 03: Abaigael Savio: 70%, Afra Shaikh: 30%
-- Statement 04: Abaigael Savio: 70%, Afra Shaikh: 30%
-- Statement 05: Abaigael Savio: 70%, Afra Shaikh: 30%
-- Statement 06: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 07: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 08: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 09: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 10: Abaigael Savio: 30%, Afra Shaikh: 70%
--
-- SECTION 2: INTERMEDIATE STATEMENTS
-- Statement 11: Abaigael Savio: 70%, Afra Shaikh: 30%
-- Statement 12: Abaigael Savio: 70%, Afra Shaikh: 30%
-- Statement 13: Abaigael Savio: 70%, Afra Shaikh: 30%
-- Statement 14: Abaigael Savio: 70%, Afra Shaikh: 30%
-- Statement 15: Abaigael Savio: 70%, Afra Shaikh: 30%
-- Statement 16: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 17: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 18: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 19: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 20: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 21: Abaigael Savio: 70%, Afra Shaikh: 30%
--
-- SECTION 3: COMPLEX STATEMENTS
-- Statement 22: Abaigael Savio: 70%, Afra Shaikh: 30%
-- Statement 22 (revised): Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 23: Abaigael Savio: 70%, Afra Shaikh: 30%
-- Statement 24: Abaigael Savio: 70%, Afra Shaikh: 30%
-- Statement 25: Abaigael Savio: 70%, Afra Shaikh: 30%
-- Statement 25 (revised): Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 26: Abaigael Savio: 70%, Afra Shaikh: 30%
-- Statement 27: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 28: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 29: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 30: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 31: Abaigael Savio: 70%, Afra Shaikh: 30%
-- Statement 32: Abaigael Savio: 30%, Afra Shaikh: 70%
--
-- SECTION 4: USE CASE WORKFLOW (INSERT-BASED)
-- Statement 33: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 34: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 35: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 36: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 37: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 38: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 39: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 40: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 41: Abaigael Savio: 30%, Afra Shaikh: 70%
-- Statement 42: Abaigael Savio: 30%, Afra Shaikh: 70%
-- ============================================================================

-- Ensure SQLite foreign key constraints are enforced
PRAGMA foreign_keys = ON;

-- Set output format for readability during evaluation
.headers on
.mode column


-- ============================================================================
-- SECTION 1: SIMPLE STATEMENTS (Statements 1 to 10)
-- ============================================================================

-- Statement 01: Big venues : Shows venues that hold 300 or more people, biggest first.
SELECT venue_name, capacity, rental_fee
FROM Venues
WHERE capacity >= 300
ORDER BY capacity DESC;

-- Statement 02: Events with Comedy in the name : Finds events that have the word Comedy in the name.
SELECT event_id, event_name, event_date
FROM Events
WHERE event_name LIKE '%Comedy%'
ORDER BY event_date;

-- Statement 03: Count events : Counts how many events there are.
SELECT COUNT(*) AS total_events
FROM Events;

-- Statement 04: Add an event manager : Adds a new event manager.
INSERT INTO EventManagers (manager_id, name, email, phone)
VALUES (4, 'Noor Rahman', 'noor.rahman@mercedtheater.example', '209-555-0144');

-- Statement 05: Change a venue fee : Changes the rental fee for the Courtyard Stage to 650.
UPDATE Venues
SET rental_fee = 650.00
WHERE venue_id = 5;

-- Statement 06: Folk performers : Lists the folk performers in alphabetical order.
SELECT performer_id, stage_name, genre, contact_email
FROM Performers
WHERE genre = 'Folk'
ORDER BY stage_name;

-- Statement 07: Fee stats : Gets the average, lowest, and highest performer fee.
SELECT ROUND(AVG(fee), 2) AS avg_fee,
       MIN(fee) AS min_fee,
       MAX(fee) AS max_fee
FROM Performances;

-- Statement 08: Spring sales : Shows ticket sales from March 1 to May 31, 2026, newest first.
SELECT sale_id, customer_name, sale_date, total_amount
FROM TicketSales
WHERE sale_date BETWEEN '2026-03-01 00:00:00' AND '2026-05-31 23:59:59'
ORDER BY sale_date DESC;

-- Statement 09: Add a performer : Adds a new performer.
INSERT INTO Performers (performer_id, stage_name, genre, contact_email)
VALUES (9, 'Neon Static', 'Rock', 'booking@neonstatic.example');

-- Statement 10: Delete a performer : Deletes the performer we just added in 09.
DELETE FROM Performers
WHERE performer_id = 9;


-- ============================================================================
-- SECTION 2: INTERMEDIATE STATEMENTS (Statements 11 to 21)
-- ============================================================================

-- Statement 11: Events with venue and manager : Shows each event with its venue and manager.
SELECT e.event_name, e.event_date, v.venue_name, m.name AS manager
FROM Events e
JOIN Venues v ON e.venue_id = v.venue_id
JOIN EventManagers m ON e.manager_id = m.manager_id
ORDER BY e.event_date;

-- Statement 12: Owners with 2 or more venues : Shows owners who have at least 2 venues and their total capacity.
SELECT o.owner_name,
       COUNT(*) AS venue_count,
       SUM(v.capacity) AS total_capacity
FROM VenueOwners o
JOIN Venues v ON v.owner_id = o.owner_id
GROUP BY o.owner_id, o.owner_name
HAVING COUNT(*) >= 2
ORDER BY total_capacity DESC;

-- Statement 13: Events with no tickets : Shows events that have no ticket types yet.
SELECT e.event_id, e.event_name, e.event_date
FROM Events e
LEFT JOIN TicketTypes tt ON tt.event_id = e.event_id
WHERE tt.ticket_type_id IS NULL;

-- Statement 14: Tickets left per event : Adds up the tickets still available for each event.
SELECT e.event_name,
       COUNT(tt.ticket_type_id) AS ticket_types,
       SUM(tt.qty_available) AS tickets_remaining
FROM Events e
JOIN TicketTypes tt ON tt.event_id = e.event_id
GROUP BY e.event_id, e.event_name
ORDER BY tickets_remaining DESC;

-- Statement 15: Raise price on almost sold out tickets : Raises the price 10% on ticket types with 5 or fewer left, for events after 2026-11-16.
UPDATE TicketTypes
SET price = ROUND(price * 1.10, 2)
WHERE qty_available <= 5
  AND event_id IN (SELECT event_id
                   FROM Events
                   WHERE event_date > '2026-11-16');

-- Statement 16: Performer fees : Shows how many events each performer plays and the total fees they earn.
SELECT p.stage_name,
       p.genre,
       COUNT(pf.event_id) AS events_played,
       SUM(pf.fee) AS total_fees
FROM Performers p
JOIN Performances pf ON pf.performer_id = p.performer_id
GROUP BY p.performer_id, p.stage_name, p.genre
ORDER BY total_fees DESC;

-- Statement 17: Revenue per event : Shows tickets sold and money made for each event.
SELECT e.event_name,
       SUM(si.quantity) AS tickets_sold,
       SUM(si.quantity * si.unit_price) AS revenue
FROM SaleItems si
JOIN TicketTypes tt ON si.ticket_type_id = tt.ticket_type_id
JOIN Events e ON tt.event_id = e.event_id
GROUP BY e.event_id, e.event_name
ORDER BY revenue DESC;

-- Statement 18: Performers never booked : Shows performers who are not booked for any event.
SELECT p.performer_id, p.stage_name, p.genre
FROM Performers p
LEFT JOIN Performances pf ON pf.performer_id = p.performer_id
WHERE pf.event_id IS NULL;

-- Statement 19: Top customers : Shows customers who spent $5,000 or more in total.
SELECT customer_name,
       COUNT(*) AS orders,
       SUM(total_amount) AS total_spent
FROM TicketSales
GROUP BY customer_name
HAVING SUM(total_amount) >= 5000
ORDER BY total_spent DESC;

-- Statement 20: Raise jazz fees : Raises jazz performer fees by 5% for events after 2026-11-16.
UPDATE Performances
SET fee = ROUND(fee * 1.05, 2)
WHERE performer_id IN (SELECT performer_id
                       FROM Performers
                       WHERE genre = 'Jazz')
  AND event_id IN (SELECT event_id
                   FROM Events
                   WHERE event_date > '2026-11-16');

-- Statement 21: Venues above average fee : Shows venues that cost more than the average rental fee.
SELECT venue_name, rental_fee
FROM Venues
WHERE rental_fee > (SELECT AVG(rental_fee) FROM Venues)
ORDER BY rental_fee DESC;


-- ============================================================================
-- SECTION 3: COMPLEX STATEMENTS (Statements 22 to 32, plus new versions of 22 and 25)
-- ============================================================================

-- Statement 22: Unsold ticket value : Uses a CTE to find events with more unsold ticket value than average.
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

-- Statement 22 (revised): Revenue above average (new version) : Newer version of 22 that uses real sales. Shows events that made more than the average revenue.
WITH event_revenue AS (
    SELECT tt.event_id,
           SUM(si.quantity * si.unit_price) AS revenue
    FROM SaleItems si
    JOIN TicketTypes tt ON si.ticket_type_id = tt.ticket_type_id
    GROUP BY tt.event_id
)
SELECT e.event_name, er.revenue
FROM event_revenue er
JOIN Events e ON e.event_id = er.event_id
WHERE er.revenue > (SELECT AVG(revenue) FROM event_revenue)
ORDER BY er.revenue DESC;

-- Statement 23: Rebooking chain : Follows the rebookings starting from event 1.
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

-- Statement 24: Venues with no events : Shows venues that have no events.
SELECT v.venue_id, v.venue_name, v.capacity
FROM Venues v
WHERE NOT EXISTS (SELECT 1
                  FROM Events e
                  WHERE e.venue_id = v.venue_id);

-- Statement 25: Event view : Makes a view with each event's venue, manager, tickets left, and venue cost, then selects from it.
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

-- Statement 25 (revised): Event view (new version) : Rebuilds the view to also show tickets sold, revenue, performer cost, and profit.
DROP VIEW IF EXISTS EventFinancials;

CREATE VIEW EventFinancials AS
SELECT t.*,
       t.ticket_revenue - t.venue_cost - t.performer_cost AS net_profit
FROM (
    SELECT e.event_id,
           e.event_name,
           e.event_date,
           v.venue_name,
           m.name AS manager_name,
           (SELECT COUNT(*) FROM TicketTypes tt
            WHERE tt.event_id = e.event_id) AS ticket_types,
           COALESCE((SELECT SUM(tt.qty_available) FROM TicketTypes tt
                     WHERE tt.event_id = e.event_id), 0) AS tickets_remaining,
           COALESCE((SELECT SUM(tt.price * tt.qty_available) FROM TicketTypes tt
                     WHERE tt.event_id = e.event_id), 0) AS unsold_value,
           COALESCE((SELECT SUM(si.quantity)
                     FROM SaleItems si
                     JOIN TicketTypes tt ON si.ticket_type_id = tt.ticket_type_id
                     WHERE tt.event_id = e.event_id), 0) AS tickets_sold,
           COALESCE((SELECT SUM(si.quantity * si.unit_price)
                     FROM SaleItems si
                     JOIN TicketTypes tt ON si.ticket_type_id = tt.ticket_type_id
                     WHERE tt.event_id = e.event_id), 0) AS ticket_revenue,
           v.rental_fee AS venue_cost,
           COALESCE((SELECT SUM(pf.fee) FROM Performances pf
                     WHERE pf.event_id = e.event_id), 0) AS performer_cost
    FROM Events e
    JOIN Venues v ON e.venue_id = v.venue_id
    JOIN EventManagers m ON e.manager_id = m.manager_id
) AS t;

SELECT event_name, tickets_sold, ticket_revenue, venue_cost, performer_cost, net_profit
FROM EventFinancials
ORDER BY net_profit DESC;

-- Statement 26: Ticket status labels : Labels each event as sold out, almost sold out, selling, or plenty available.
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

-- Statement 27: Rank performers by fee : Ranks the performers at each event by fee.
SELECT e.event_name,
       p.stage_name,
       pf.fee,
       DENSE_RANK() OVER (PARTITION BY e.event_id ORDER BY pf.fee DESC) AS fee_rank
FROM Performances pf
JOIN Events e ON pf.event_id = e.event_id
JOIN Performers p ON pf.performer_id = p.performer_id
ORDER BY e.event_id, fee_rank;

-- Statement 28: Biggest sale per customer : Shows each customer's biggest sale.
WITH ranked_sales AS (
    SELECT customer_name, sale_id, sale_date, total_amount,
           ROW_NUMBER() OVER (PARTITION BY customer_name
                              ORDER BY total_amount DESC) AS rn
    FROM TicketSales
)
SELECT customer_name, sale_id, sale_date, total_amount
FROM ranked_sales
WHERE rn = 1
ORDER BY total_amount DESC;

-- Statement 29: Contact list : Combines owners, managers, and performers into one contact list.
SELECT owner_name AS name, email, 'Venue Owner' AS role FROM VenueOwners
UNION
SELECT name, email, 'Event Manager' FROM EventManagers
UNION
SELECT stage_name, contact_email, 'Performer' FROM Performers
ORDER BY role, name;

-- Statement 30: Performers by venue : Shows performers who played the Main Hall but not the Black Box, and also played Valley Amphitheater.
SELECT p.stage_name
FROM Performers p
JOIN Performances pf ON pf.performer_id = p.performer_id
JOIN Events e ON e.event_id = pf.event_id
WHERE e.venue_id = 1
EXCEPT
SELECT p.stage_name
FROM Performers p
JOIN Performances pf ON pf.performer_id = p.performer_id
JOIN Events e ON e.event_id = pf.event_id
WHERE e.venue_id = 2
INTERSECT
SELECT p.stage_name
FROM Performers p
JOIN Performances pf ON pf.performer_id = p.performer_id
JOIN Events e ON e.event_id = pf.event_id
WHERE e.venue_id = 3;

-- Statement 31: Trigger for rebooked events : When an event is rebooked, copies the old event's ticket types to the new one. Tests it, then deletes the test event.
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

-- test: rebook event 5 as event 13
INSERT INTO Events (event_id, event_name, event_date, venue_id, manager_id, rebooked_from_event_id)
VALUES (13, 'Local Comedy Showcase Encore', '2027-02-20 20:00:00', 2, 3, 5);

-- check that event 13 got the ticket types
SELECT e.event_name, tt.category, tt.price, tt.qty_available
FROM Events e
JOIN TicketTypes tt ON tt.event_id = e.event_id
WHERE e.event_id = 13;

-- delete the test event (its ticket types go with it)
DELETE FROM Events
WHERE event_id = 13;

-- Statement 32: Triggers for ticket sales : Updates tickets left and the sale total when a sale item is added or removed. Tests it, then deletes the test sale.
DROP TRIGGER IF EXISTS trg_saleitems_after_insert;
DROP TRIGGER IF EXISTS trg_saleitems_after_delete;

CREATE TRIGGER trg_saleitems_after_insert
AFTER INSERT ON SaleItems
BEGIN
    UPDATE TicketTypes
    SET qty_available = qty_available - NEW.quantity
    WHERE ticket_type_id = NEW.ticket_type_id;

    UPDATE TicketSales
    SET total_amount = total_amount + (NEW.quantity * NEW.unit_price)
    WHERE sale_id = NEW.sale_id;
END;

CREATE TRIGGER trg_saleitems_after_delete
AFTER DELETE ON SaleItems
BEGIN
    UPDATE TicketTypes
    SET qty_available = qty_available + OLD.quantity
    WHERE ticket_type_id = OLD.ticket_type_id;

    UPDATE TicketSales
    SET total_amount = total_amount - (OLD.quantity * OLD.unit_price)
    WHERE sale_id = OLD.sale_id;
END;

-- test sale: 2 tickets of type 21 at $30
INSERT INTO TicketSales (sale_id, customer_name, sale_date, total_amount)
VALUES (18, 'Demo Customer', '2026-11-16 12:00:00', 0.0);

INSERT INTO SaleItems (sale_id, ticket_type_id, quantity, unit_price)
VALUES (18, 21, 2, 30.00);

-- check: total should be 60 and tickets left should be 148
SELECT s.sale_id, s.total_amount, tt.qty_available AS type21_qty_remaining
FROM TicketSales s, TicketTypes tt
WHERE s.sale_id = 18 AND tt.ticket_type_id = 21;

-- remove the item
DELETE FROM SaleItems
WHERE sale_id = 18 AND ticket_type_id = 21;

-- check: total back to 0 and tickets left back to 150
SELECT s.sale_id, s.total_amount, tt.qty_available AS type21_qty_remaining
FROM TicketSales s, TicketTypes tt
WHERE s.sale_id = 18 AND tt.ticket_type_id = 21;

-- delete the test sale
DELETE FROM TicketSales
WHERE sale_id = 18;


-- ============================================================================
-- SECTION 4: USE CASE WORKFLOW (Statements 33 to 42)
-- Follows the Checkpoint 1 use case: a group books a gig, the event manager
-- creates the event, ticket types, and performers, and a customer buys tickets.
-- Everything created here is removed again in Statement 42.
-- ============================================================================

-- Statement 33: Check date availability : Shows the venues that have no event on 2027-03-06, so the date can be booked.
SELECT v.venue_id, v.venue_name, v.capacity
FROM Venues v
WHERE NOT EXISTS (SELECT 1
                  FROM Events e
                  WHERE e.venue_id = v.venue_id
                    AND DATE(e.event_date) = '2027-03-06')
ORDER BY v.capacity DESC;

-- Statement 34: Create an event : Adds a new event at Sierra Hall (venue 4) managed by the new manager from Statement 04.
INSERT INTO Events (event_id, event_name, event_date, venue_id, manager_id, rebooked_from_event_id)
VALUES (14, 'Spring Dance Recital', '2027-03-06 19:00:00', 4, 4, NULL);

-- Statement 35: Create ticket types : Adds two ticket types (General and Student) to the new event with one multi-row INSERT.
INSERT INTO TicketTypes (event_id, category, price, qty_available)
VALUES (14, 'General', 20.00, 100),
       (14, 'Student', 10.00, 50);

-- Statement 36: Book performers : Adds two performers to the new event with their fees and set order.
INSERT INTO Performances (event_id, performer_id, fee, set_order)
VALUES (14, 7, 650.00, 1),
       (14, 8, 400.00, 2);

-- Statement 37: Adjust ticket price : Raises the General ticket price for the new event by $5.
UPDATE TicketTypes
SET price = price + 5.00
WHERE event_id = 14
  AND category = 'General';

-- Statement 38: Check ticket availability : Shows the ticket types for the new event that still have at least 4 tickets left.
SELECT ticket_type_id, category, price, qty_available
FROM TicketTypes
WHERE event_id = 14
  AND qty_available >= 4
ORDER BY price DESC;

-- Statement 39: Start a ticket sale : Creates an empty sale for a customer (the SaleItems trigger fills in the total).
INSERT INTO TicketSales (sale_id, customer_name, sale_date, total_amount)
VALUES (19, 'Riley Cooper', '2026-11-16 15:30:00', 0.0);

-- Statement 40: Add tickets to the sale : Uses INSERT ... SELECT to buy 4 General and 2 Student tickets at the current prices; the triggers lower tickets left and raise the sale total.
INSERT INTO SaleItems (sale_id, ticket_type_id, quantity, unit_price)
SELECT 19,
       ticket_type_id,
       CASE category WHEN 'General' THEN 4 ELSE 2 END,
       price
FROM TicketTypes
WHERE event_id = 14;

-- Statement 41: Revenue and cost report : Shows the new event's tickets sold, revenue, venue and performer costs, and profit; the sale total should be 120.
SELECT f.event_name, f.tickets_sold, f.ticket_revenue, f.tickets_remaining,
       f.venue_cost, f.performer_cost, f.net_profit,
       (SELECT total_amount FROM TicketSales WHERE sale_id = 19) AS sale_19_total
FROM EventFinancials f
WHERE f.event_id = 14;

-- Statement 42: Clean up the demo : Removes the demo sale, then the demo event (its ticket types and performances go with it by ON DELETE CASCADE).
DELETE FROM SaleItems
WHERE sale_id = 19;

DELETE FROM TicketSales
WHERE sale_id = 19;

DELETE FROM Events
WHERE event_id = 14;
