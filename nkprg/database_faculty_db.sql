CREATE DATABASE faculty_db;

USE faculty_db;

CREATE TABLE faculty (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  title VARCHAR(100),
  department VARCHAR(100),
  email VARCHAR(100),
  phone VARCHAR(50),
  bio TEXT,
  photo VARCHAR(255)
);
CREATE TABLE admin_users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL -- store hashed passwords!
);
INSERT INTO admin_users (username, password)
VALUES ('admin', 'admin123');
select * from admin_users;
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (1, 'Dr.S.Ravikumar', 'Professor', 'Department of oceanography and coastal area studies', 'ravibiotech201320@yahoo.com', '(+91)4561 243470', 'Teaching experience: 20 years\r\nResearch experience: 19 years', 'ravikumar.jpg');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (4, 'Dr. K. CHANDRASEKAR', 'Associate Professor', 'cum-Placement officer', 'chandrasekark@alagappauniversity.ac.in', '04565-225211', 'Research Experience : 12', 'K_Chandrasekar.png');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (5, 'Dr. M. NATARAJAN', 'Assistant Professor', 'Department of English and Foreign Languages', 'natarajanm@alagappauniversity.ac.in', '04565 223226', 'Teaching Experience : 11 Years 
Research Experience: 11 Years ', 'natarajan.jpg');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (6, 'Dr. A. Narayanamoorthy', 'Senior Professor and head', 'Department of Economics and Rural Development', 'narayana64@gmail.com', '91-4565-225842', 'Teaching Experience : 31 Years', 'narayanamurthi.jpg');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (7, 'Dr.R. ALAMELUMANGAI', 'Senior Professor & Head ', 'Department of English and Foreign Languages', 'amangair@gmail.com', '04565-223 541 ', 'Academic Qualifications: M.Com., M.Phil., Ph.D., DRD
Teaching Experience : 34 Years 
Research Experience : 32 Years ', 'alamelumangai.jpg');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (8, 'Dr.N.SASIKUMAR', 'Assistant Professor', 'Department of Education', 'sasikumar@alagappauniversity.ac.in', '+91 4565 230207', 'Academic Qualifications: M.Sc., M.Sc., MPhil., M.Ed., Ph.D., NET(Edu)., SET(Edu)
Research Experience: 11 years', 'sasikumar.jpg');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (9, 'DR S KISHORE KUMAR', 'DEPUTY LIBRARIAN', 'CENTRAL LIBRARY', 'kishore@yahoo.com', '9444138098', 'Academic Qualifications : M.Sc., B.Ed, M.L.I.Sc, M.Phil, PGDLAN, Ph.D. 
Total Teaching
Experience : Years - 27', 'kishore.jpg');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (10, 'Dr. SP. M. KANIMOZHI', 'Assistant Professor', 'Department of English and Foreign Languages', 'kanimozhi@gmail.com', '+91 4565228724 ', 'Total Teaching Experience : 13 Years
Total Research Experience : 10 Years', 'kanimozhi.jpg');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (11, 'Dr. R. Suresh ', 'Assistant Professor personal', 'Department of Economics and Rural Development', 'suresh@gmail.com', '7398783451', 'Total Teaching Experience : 8 Years
Total Research Experience : 8 Years', 'suresh.jpg');
select * from faculty;
SELECT CONCAT(
    'INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (',
    id, ', ',
    QUOTE(name), ', ',
    QUOTE(title), ', ',
    QUOTE(department), ', ',
    QUOTE(email), ', ',
    QUOTE(phone), ', ',
    QUOTE(bio), ', ',
    QUOTE(photo),
    ');'
) AS export_sql
FROM faculty;
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (1, 'Dr.S.Ravikumar', 'Professor', 'Department of oceanography and coastal area studies', 'ravibiotech201320@yahoo.com', '(+91)4561 243470', 'Teaching experience: 20 years
Research experience: 19 years', 'ravikumar.jpg');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (10, 'Dr. SP. M. KANIMOZHI', 'Assistant Professor', 'Department of English and Foreign Languages', 'kanimozhi@gmail.com', '+91 4565228724 ', 'Total Teaching Experience : 13 Years
Total Research Experience : 10 Years', 'kanimozhi.jpg');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (11, 'Dr. R. Suresh ', 'Assistant Professor personal', 'Department of Economics and Rural Development', 'suresh@gmail.com', '7398783451', 'Total Teaching Experience : 8 Years
Total Research Experience : 8 Years', 'suresh.jpg');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (13, 'Dr. K. Gunasekaran', 'Assistant Professor', 'Department of Special Education and Rehabilitation Science', 'gunasekaran@gmail.com', '9842653579', 'Total Teaching Experience : 15 Years
Total Research Experience : 15 Years
', 'gunasekaran.jfif');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (14, 'Dr. M. JOTHI BASU', 'Associate Professor', 'Botany', 'jothibasu@alagappauniversity.ac.in', '+91 4565 223 401', 'Total Teaching Experience : 16 Years
Total Research Experience : 15 years', 'jothibasu.jfif');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (15, 'Dr. T. KAVITHA', 'Assistant Professor', 'Department of Microbiology, School of Biological Sciences', 'kavitha@alagappauniversity.ac.in', '+91 4565 228095', 'Total Teaching Experience : 16 Years
Total Research Experience : 8 Years', 'kavitha.jfif');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (16, 'Dr. R. Yuvakkumar', 'Assistant Professor', 'Department of Physics', 'yuvakumar@gmail.com', '+91 4565 223308', 'Total Teaching Experience : 8 Years
Total Research Experience : 10 Years
', 'yuvakumar.jfif');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (17, 'Dr. S. Santhoshkumar', 'Assistant Professor', 'Department of Computer Science', 'santhoshkumar@gmail.com', '+91 4565 223661/665', 'Total Teaching Experience : 20 Years
Total Research Experience:13 years
', 'santhoshkumar.jfif');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (18, 'DR. S. PARAMASIVAM', 'ASSOCIATE PROFESSOR', 'Department of Oceanography & Coastal Area Studies', 'paramasivam@gmail.com', '+91 9047733300', 'Teaching Experience : 15 years
Total Research Experience : 17 Years', 'paramasivam.jfif');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (19, 'Dr.V.A.ANAND', 'ASSISTANT PROFESSOR', 'Department of Logistics Management', 'anand@gmail.com', '04565 - 223556', 'Total Teaching Experience : 14.6 Years
Total Research Experience : 08 Years', 'anand.jfif');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (20, ' Dr.B.Menaka', ' Assistant Professor', 'Department of Commerce', 'menaka@gmail.com', '+91 4565 225208', 'Total Experience: 9 Years
Total Research Experience: 10 Years', 'menaka.jfif');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (21, 'Dr. T. Meyyappan', 'Professor', 'Department of Computer Science', 'meyyappan@gmail.com', '914565-223663', 'Total Teaching Experience : 33 Years
Total Research Experience : 22 Years', 'meyyappan.jfif');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (22, 'Dr. C. VETHIRAJAN', 'SENIOR PROFESSOR & HEAD', 'Department of Corporate Secretaryship', 'vethirajan@gmail.com', '04565-230202', 'Total Teaching Experience : 27 Years
Total Research Experience : 18 Years', 'vethirajan.jfif');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (23, 'SHAKKTHIVEL P', 'Professor', ': Department of Nanoscience and Technology', 'shakkthivel@yahoo.com', '+91 4565 223 372', 'Academic Qualifications: M.Sc., Ph.D.
Teaching Experience: 22 Years
Research Experience: 25 Years', 'shakkthivel.jfif');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (4, 'Dr. K. CHANDRASEKAR', 'Associate Professor', 'cum-Placement officer', 'chandrasekark@alagappauniversity.ac.in', '04565-225211', 'Research Experience : 12', 'K_Chandrasekar.png');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (5, 'Dr. M. NATARAJAN', 'Assistant Professor', 'Department of English and Foreign Languages', 'natarajanm@alagappauniversity.ac.in', '04565 223226', 'Teaching Experience : 11 Years 
Research Experience: 11 Years ', 'natarajan.jpg');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (6, 'Dr. A. Narayanamoorthy', 'Senior Professor and head', 'Department of Economics and Rural Development', 'narayana64@gmail.com', '91-4565-225842', 'Teaching Experience : 31 Years', 'narayanamurthi.jpg');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (7, 'Dr.R. ALAMELUMANGAI', 'Senior Professor & Head ', 'Department of English and Foreign Languages', 'amangair@gmail.com', '04565-223 541 ', 'Academic Qualifications: M.Com., M.Phil., Ph.D., DRD
Teaching Experience : 34 Years 
Research Experience : 32 Years ', 'alamelumangai.jpg');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (8, 'Dr.N.SASIKUMAR', 'Assistant Professor', 'Department of Education', 'sasikumar@alagappauniversity.ac.in', '+91 4565 230207', 'Academic Qualifications: M.Sc., M.Sc., MPhil., M.Ed., Ph.D., NET(Edu)., SET(Edu)
Research Experience: 11 years', 'sasikumar.jpg');
INSERT INTO faculty (id, name, title, department, email, phone, bio, photo) VALUES (9, 'DR S KISHORE KUMAR', 'DEPUTY LIBRARIAN', 'CENTRAL LIBRARY', 'kishore@yahoo.com', '9444138098', 'Academic Qualifications : M.Sc., B.Ed, M.L.I.Sc, M.Phil, PGDLAN, Ph.D. 
Total Teaching
Experience : Years - 27', 'kishore.jpg');
CREATE TABLE feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    faculty_id INT NOT NULL,
    name VARCHAR(100),
    comment TEXT NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (faculty_id) REFERENCES faculty(id) ON DELETE CASCADE
);
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('faculty', 'student') NOT NULL
);
INSERT INTO users (username, password, role) VALUES ('faculty1', 'pass123', 'faculty');
INSERT INTO users (username, password, role) VALUES ('student1', 'pass123', 'student');
CREATE TABLE ratings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    faculty_id INT NOT NULL,
    stars INT CHECK (stars BETWEEN 1 AND 5),
    comment TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (faculty_id) REFERENCES faculty(id) ON DELETE CASCADE
);




