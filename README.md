# Merced Theater Venue Management

**CSE 111, Fall 2026 · Project Checkpoint 2**
**Team:** Abaigael Savio, Afra Shaikh

A SQLite3 database for booking events, managing venues and performers, and selling tickets at Merced Theater. It has 9 tables: VenueOwners, Venues, EventManagers, Performers, Events, Performances, TicketTypes, TicketSales, and SaleItems.

## Files

| File | Purpose |
|---|---|
| `Checkpoint2-dbase.sqlite3` | The submitted database: all 9 tables, populated with sample data. |
| `Checkpoint2-script.sql` | The graded script: 44 numbered statements (simple, intermediate, and complex), each with a short explanation. |
| `Checkpoint2.sql` | Supporting file. Rebuilds the whole database from an empty file. Not for grading. |

## How to run (for grading)

Put `Checkpoint2-dbase.sqlite3` and `Checkpoint2-script.sql` in the same folder, then run:

```
sqlite3 Checkpoint2-dbase.sqlite3
.read Checkpoint2-script.sql
```

The script prints the results of every query. It should finish with no errors.

## Important notes

- **Run the script once on the database as submitted.** A few statements make permanent changes: Statement 04 adds an event manager, Statement 05 changes a venue fee, and Statements 15 and 20 raise some ticket prices and performer fees. Running the script a second time on the same file fails with a duplicate-key error in Statement 04.
- **To test more than once, use a copy:**
  ```
  cp Checkpoint2-dbase.sqlite3 test.sqlite3
  sqlite3 test.sqlite3
  .read Checkpoint2-script.sql
  ```
- **Demo data cleans itself up.** The trigger tests (Statements 31 and 32) and the use-case section (Statements 33 to 42) insert demo rows and delete them again before the script ends.
- **Do not run `Checkpoint2.sql` on the submitted database.** It creates the tables, so it only works on an empty file:
  ```
  sqlite3 new.sqlite3
  .read Checkpoint2.sql
  ```

## Schema changes since Checkpoint 1

None to the tables. The script adds one view (`EventFinancials`) and three triggers (`trg_events_after_rebook`, `trg_saleitems_after_insert`, `trg_saleitems_after_delete`). More detail is in the header of `Checkpoint2-script.sql`.
