-- DeadlineDock: Academic Task & Deadline Management System
-- SQLite schema + sample data (this exact script is also embedded in index.html)

-- SQLite does not enforce foreign keys unless this is switched on
PRAGMA foreign_keys = ON;

-- Parent table (the "one" side of the 1:N relationship)
CREATE TABLE courses (
    course_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    course_code TEXT NOT NULL UNIQUE,   -- UNIQUE prevents duplicate courses
    course_name TEXT NOT NULL,
    instructor  TEXT
);

-- Child table (the "many" side): each task may belong to one course
CREATE TABLE tasks (
    task_id     INTEGER PRIMARY KEY AUTOINCREMENT,
    title       TEXT NOT NULL,
    description TEXT,
    course_id   INTEGER,
    category    TEXT NOT NULL
        CHECK (category IN ('Assignment','Lab Report','Quiz','Exam','Presentation','Other')),
    due_date    TEXT NOT NULL,          -- stored as YYYY-MM-DD
    priority    TEXT NOT NULL
        CHECK (priority IN ('Low','Medium','High')),
    status      TEXT NOT NULL DEFAULT 'Pending'
        CHECK (status IN ('Pending','In Progress','Completed')),
    created_at  TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Sample courses
INSERT INTO courses (course_code, course_name, instructor) VALUES
('CSE-301', 'Database Management Systems', 'Dr. Rahman'),
('CSE-305', 'Data Structures and Algorithms', 'Ms. Akter'),
('CSE-311', 'Computer Networks', 'Mr. Hossain'),
('MAT-201', 'Discrete Mathematics', 'Dr. Chowdhury'),
('ENG-101', 'Technical Writing', 'Ms. Sultana');

-- Sample tasks (a mix of past and future dates so overdue tracking can be demonstrated)
INSERT INTO tasks (title, description, course_id, category, due_date, priority, status) VALUES
('ER Diagram Assignment', 'Draw the ER diagram for a library system.', 1, 'Assignment', '2026-11-05', 'High', 'Pending'),
('SQL Lab Report 3', 'Report on JOIN and GROUP BY queries.', 1, 'Lab Report', '2026-11-20', 'Medium', 'In Progress'),
('DBMS Final Project Demo', 'Present the DeadlineDock project.', 1, 'Presentation', '2026-12-05', 'High', 'In Progress'),
('Sorting Algorithms Quiz', 'Covers merge sort, quick sort and heap sort.', 2, 'Quiz', '2026-11-12', 'Medium', 'Completed'),
('Binary Tree Assignment', 'Implement BST insert, delete and traversal.', 2, 'Assignment', '2026-11-25', 'High', 'Pending'),
('Subnetting Lab Report', 'Subnetting exercises from Lab 4.', 3, 'Lab Report', '2026-11-09', 'Low', 'Pending'),
('Networks Mid-term Exam', 'Chapters 1 to 5.', 3, 'Exam', '2026-12-01', 'High', 'Pending'),
('Graph Theory Problem Set', 'Problems 1 to 15 from Chapter 6.', 4, 'Assignment', '2026-11-18', 'Medium', 'Completed'),
('Research Summary Presentation', 'Five-minute talk on a chosen paper.', 5, 'Presentation', '2026-12-10', 'Low', 'Pending'),
('Reading Reflection', 'One-page reflection on the assigned article.', NULL, 'Other', '2026-11-30', 'Low', 'In Progress');
