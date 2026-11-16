# DeadlineDock
**Academic Task & Deadline Management System** – a DBMS lab project.

## Project Description
DeadlineDock is a single-page web app that helps students track assignments, lab reports, quizzes, exams and presentations. It runs a real **SQLite** database inside the browser using the **sql.js** library, so every feature is powered by genuine SQL queries and no backend is needed.

## Objectives
- Design a small relational database with a primary key, foreign key, UNIQUE and CHECK constraints.
- Demonstrate SQL operations (CRUD, JOIN, aggregate functions, GROUP BY) in a real application.
- Build a static website that can be hosted free on GitHub Pages.

## Technologies Used
HTML5, CSS3, Vanilla JavaScript, SQLite via sql.js 1.10.3 (CDN), localStorage (persistence), GitHub Pages (deployment).

## Project Structure
```
DeadlineDock/
├── index.html    (HTML + CSS + JavaScript)
├── database.sql  (schema, constraints, sample data)
└── README.md
```
`index.html` embeds the same SQL that is in `database.sql`, so the two always match.

## Features
- Dashboard cards: Total, Pending, Completed and Overdue tasks (SQL `COUNT`).
- Tasks by category and by course (`GROUP BY`), completion rate (`AVG`), next and furthest deadline (`MIN`/`MAX`).
- Add, edit, cancel-edit and delete tasks (with a delete confirmation).
- Add courses; duplicate course codes are rejected.
- Search by title; filter by course, category, status and priority (SQL `WHERE`).
- Tasks sorted by due date; overdue tasks highlighted; coloured priority and status badges.
- Empty-state message, success/error messages, form validation.
- Reset to the original sample data (with confirmation).
- Data survives page refresh.

## Database Design
### `courses`
| Column | Type | Notes |
|---|---|---|
| course_id | INTEGER | Primary key, auto-increment |
| course_code | TEXT | NOT NULL, UNIQUE |
| course_name | TEXT | NOT NULL |
| instructor | TEXT | optional |

### `tasks`
| Column | Type | Notes |
|---|---|---|
| task_id | INTEGER | Primary key, auto-increment |
| title | TEXT | NOT NULL |
| description | TEXT | optional |
| course_id | INTEGER | Foreign key → courses(course_id) |
| category | TEXT | NOT NULL, CHECK (Assignment, Lab Report, Quiz, Exam, Presentation, Other) |
| due_date | TEXT | NOT NULL, format YYYY-MM-DD |
| priority | TEXT | NOT NULL, CHECK (Low, Medium, High) |
| status | TEXT | NOT NULL, DEFAULT 'Pending', CHECK (Pending, In Progress, Completed) |
| created_at | TEXT | DEFAULT CURRENT_TIMESTAMP |

### Relationship
**One course has many tasks (1:N).** `tasks.course_id` references `courses.course_id`. `PRAGMA foreign_keys = ON` is executed so SQLite enforces this. A task may have no course (`course_id` NULL).

## SQL Operations Demonstrated
`CREATE TABLE`, `INSERT`, `SELECT`, `UPDATE`, `DELETE`, `WHERE`, `LIKE`, `ORDER BY`, `LEFT JOIN`, `COUNT()`, `AVG()`, `MAX()`, `MIN()`, `GROUP BY`, `CASE`, `CHECK`, `UNIQUE`, `FOREIGN KEY`. All values from users are passed as parameters (`?`) rather than joined into the SQL text.

**Overdue rule:** `status != 'Completed' AND due_date < date('now','localtime')`.

## How to Run Locally
The sql.js WebAssembly file is loaded over HTTP, so opening `index.html` by double-click may not work. Use a local server:
1. **VS Code Live Server:** install the *Live Server* extension, right-click `index.html`, choose *Open with Live Server*.
2. **Or Python:** run `python -m http.server 8000` in the project folder and open `http://localhost:8000`.

An internet connection is needed because sql.js is loaded from cdnjs.

## How to Deploy with GitHub Pages
1. Create a new public GitHub repository (e.g. `DeadlineDock`).
2. Upload `index.html`, `database.sql` and `README.md` to the repository root.
3. Go to **Settings → Pages**.
4. Under *Build and deployment*, choose **Deploy from a branch**, select `main` and `/ (root)`, then **Save**.
5. After a minute your site is live at `https://<your-username>.github.io/DeadlineDock/`.

## Database Persistence Limitations
After every add, update or delete, the SQLite database is exported with sql.js and stored in the browser's **localStorage**. It is restored on the next visit.
- Data is stored **only in the visitor's own browser**. Each visitor has a separate copy.
- This is **not** a shared multi-user database.
- Clearing browser data, using private mode or switching browsers/devices loses the data.
- Use the **Reset Database** button to return to the sample data.
